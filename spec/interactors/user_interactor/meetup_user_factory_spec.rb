require 'spec_helper'

describe UserInteractor::MeetupUserFactory do
  before :all do
    @meetup_user_id = 10540512
    @meetup_user_name = 'Foo User'
    @meetup_auth = {
      "provider"=>"meetup",
      "uid"=> @meetup_user_id,
      "info"=> {
        "id"=> @meetup_user_id,
        "name"=> @meetup_user_name,
        "photo_url"=> "http://photos3.meetupstatic.com/photos/member/4/9/a/e/member_123456789.jpeg",
        "urls"=>{
          "public_profile"=>"http://www.meetup.com/members/#{@meetup_user_id}"
        },
        "description"=>nil,
        "location"=>"Columbia, MD, us"
      },
      "credentials"=> {
        "token"=>"abcdefghijklmnopqrstuvwxyz123456",
        "refresh_token"=>"1234567890abcdefghijklmnopqrstuv",
        "expires_at"=>1365349348,
        "expires"=>true
      },
      "extra"=> {
        "raw_info"=> {
          "lat"=>39.16999816894531,
          "lon"=>-76.8499984741211,
          "link"=>"http://www.meetup.com/members/#{@meetup_user_id}",
          "state"=>"MD",
            "self"=>{ "common"=>{} },
            "lang"=>"en_US",
            "photo"=> {
              "photo_link"=> "http://photos3.meetupstatic.com/photos/member/4/9/a/e/member_123456789.jpeg",
              "thumb_link"=> "http://photos1.meetupstatic.com/photos/member/4/9/a/e/thumb_123456789.jpeg",
              "photo_id"=>123456789
            },
            "city"=>"Columbia",
            "country"=>"us",
            "id"=>10624849,
            "visited"=>1365342866000,
            "joined"=>1255462331000,
            "name"=>@meetup_user_name,
            "other_services"=>{},
            "topics"=> [
              {"id"=>939612, "urlkey"=>"angularjs", "name"=>"AngularJS"},
              {"id"=>579, "urlkey"=>"bike", "name"=>"Bicycling"},
            ],
        }
      }
    }
  end

  context "existing user" do
    before :all do
      @user = FactoryGirl.create(:user)
    end

    context "with current auth" do
      before :all do
        @exist_auth = Authorization.create(
          remote_uid: @meetup_auth['uid'],
          provider: 'meetup',
          current: true,
          user_id: @user.id
        )
      end
      after :all do
        @exist_auth.destroy
      end

      it "finds the user" do
        i = UserInteractor::MeetupUserFactory.new(@meetup_auth)
        u = i.find_or_create_user
        u.should == @user
      end

      it "stores the auth hash as extra_data" do
        i = UserInteractor::MeetupUserFactory.new(@meetup_auth)
        u = i.find_or_create_user
        auth = u.authorizations.for_provider('meetup').first
        auth.extra_data.should == @meetup_auth
      end
    end

    context "with lapsed auth" do
      before :all do
        @exist_auth = Authorization.create(
          remote_uid: @meetup_auth['uid'],
          provider: 'meetup',
          current: false,
          user_id: @user.id
        )
      end
      after :all do
        @exist_auth.destroy
      end
      it "finds the user and updates the auth to current" do
        i = UserInteractor::MeetupUserFactory.new(@meetup_auth)
        u = i.find_or_create_user
        u.should == @user
        Authorization.find(@exist_auth.id).current.should be_true
      end
    end
  end

  context "new user" do
    it "creates the new user" do
      Authorization.with_remote_uid(@meetup_user_id).should be_empty

      i = UserInteractor::MeetupUserFactory.new(@meetup_auth)
      @u = i.find_or_create_user

      @u.should_not be_new_record
      @a = @u.authorizations.first

      @a.remote_uid.to_s.should == @meetup_user_id.to_s
      @a.provider.should == 'meetup'

      @u.email.should be_nil # meetup doesn't provide...
      @u.password_digest.should be_nil # no password
    end

    after :all do
      @a.destroy if @a
      @u.destroy if @u
    end
  end

  describe "credential management" do
    context "new credentials" do
      it "stores the new credentials" do
        Authorization.with_remote_uid(@meetup_user_id).should be_empty
        i = UserInteractor::MeetupUserFactory.new(@meetup_auth)
        @u = i.find_or_create_user
        @u.credentials.should_not be_empty
        @u.credentials.count.should == 2
        token   = @u.credentials.detect{|c| c.kind == 'token' }
        refresh = @u.credentials.detect{|c| c.kind == 'refresh_token' }

        token.provider.should          == 'meetup'
        refresh.provider.should        == 'meetup'
        token.remote_uid.to_s.should   == @u.authorizations.first.remote_uid
        refresh.remote_uid.to_s.should == @u.authorizations.first.remote_uid
        token.value.should             == 'abcdefghijklmnopqrstuvwxyz123456'
        refresh.value.should           == '1234567890abcdefghijklmnopqrstuv'
        token.expires_at.to_i.should   == Time.at(1365349348).to_i
        refresh.expires_at.to_i.should == Time.at(1365349348).to_i
      end
    end

    context "existing credentials" do
      before :all do
        @user = FactoryGirl.create(:user, :with_meetup_auth, remote_uid: @meetup_user_id.to_s)
        FactoryGirl.create_list(:credential, 2, :for_meetup, user: @user)
      end

      after :all do
        @user.destroy if @user
        @u.destroy if @u
      end

      it "clears and refreshes the user's credentials" do
        before_credentials = @user.credentials
        before_credentials.any?{|c| c.value == 'abcdefghijklmnopqrstuvwxyz123456'}.should be_false

        i = UserInteractor::MeetupUserFactory.new(@meetup_auth)
        @u = i.find_or_create_user
        @u.should == @user

        @u.credentials.should_not be_empty
        @u.credentials.count.should == 2
        token   = @u.credentials.detect{|c| c.kind == 'token' }
        refresh = @u.credentials.detect{|c| c.kind == 'refresh_token' }

        token.provider.should          == 'meetup'
        refresh.provider.should        == 'meetup'
        token.remote_uid.to_s.should   == @u.authorizations.first.remote_uid
        refresh.remote_uid.to_s.should == @u.authorizations.first.remote_uid
        token.value.should             == 'abcdefghijklmnopqrstuvwxyz123456'
        refresh.value.should           == '1234567890abcdefghijklmnopqrstuv'
        token.expires_at.to_i.should   == Time.at(1365349348).to_i
        refresh.expires_at.to_i.should == Time.at(1365349348).to_i
      end
    end

  end
end
