require 'spec_helper'

describe UserInteractor::UserAuthConsumer do
  let(:unsupported_auth) {
    {"provider"=>"fakey_you_out",
     "uid"=>12345}
  }
  it "raises an exception for an unknown auth provider" do
    consumer = UserInteractor::UserAuthConsumer.new(unsupported_auth)
    expect {
      consumer.find_or_create_user
    }.to raise_error(UserInteractor::UserAuthConsumer::AuthException)
  end

  describe "meetup auth" do
    let(:meetup_user_id) { 10540512 }
    let(:meetup_user_name) { 'Foo User' }
    let(:meetup_auth) {
      {
        "provider"=>"meetup",
        "uid"=> meetup_user_id,
        "info"=> {
          "id"=> meetup_user_id,
          "name"=> meetup_user_name,
          "photo_url"=> "http://photos3.meetupstatic.com/photos/member/4/9/a/e/member_123456789.jpeg",
          "urls"=>{
            "public_profile"=>"http://www.meetup.com/members/#{meetup_user_id}"
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
            "link"=>"http://www.meetup.com/members/#{meetup_user_id}",
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
            "name"=>meetup_user_name,
            "other_services"=>{},
            "topics"=> [
              {"id"=>939612, "urlkey"=>"angularjs", "name"=>"AngularJS"},
              {"id"=>579, "urlkey"=>"bike", "name"=>"Bicycling"},
            ],
          }
        }
      }
    }

    it "uses the correct provider for a meetup auth hash" do
      consumer = UserInteractor::UserAuthConsumer.new(meetup_auth)
      consumer.should_receive(:find_or_create_meetup_user).once
      consumer.find_or_create_user
    end

    context "new user" do
      #before :all do
      #  consumer = UserInteractor::UserAuthConsumer.new(meetup_auth)
      #  @user = consumer.find_or_create_user
      #end
      it "creates an authorization based on the auth data"
      it "creates credentials based on the auth data"
      it "creates a user based on the auth data"
    end

    context "existing user" do
      context "existing authorization" do

      end
      context "new authorization" do

      end
    end
  end
end

