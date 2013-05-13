# == Schema Information
# Schema version: 20130513014550
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  name            :string(255)
#

require 'spec_helper'

describe User do
  it "should save a password hash when given a password" do
    # Note: not using FactoryGirl so we can be explicit about what parameters
    # generate a password hash or not
    u = User.create(email: 'someone@example.com',
                    password: 'foo',
                    password_confirmation: 'foo')
    u.should_not be_new_record
    u.password_digest.should_not be_nil
  end

  it "should not save a password hash when not given a password" do
    u = User.create(email: 'someone@example.com')
    u.should_not be_new_record
    u.password_digest.should be_nil
  end

  it "should validate the uniqueness of the email address" do
    email = "foo@foo.com"
    FactoryGirl.create(:user, email: email)
    FactoryGirl.build(:user, email: email).should_not be_valid
  end

  describe '#login' do
    before :all do
      @password = "boborama123"
      @valid_user = FactoryGirl.create(
        :user,
        password:              @password,
        password_confirmation: @password
      )
      @email = @valid_user.email
    end

    it "returns the correct user given the proper input" do
      User.login(@email, @password).should == @valid_user
    end

    it "does not return the user if given invalid credentials" do
      User.login(@email, @password + "blah").should be_nil
    end

    it "does not return the user if given a fake email" do
      User.login(@email + "blah", @password + "blah").should be_nil
    end
  end

  describe "#refresh_meetups!" do
    before :all do
      @user = FactoryGirl.create(:user)
    end
    it "refreshes the latest meetups from the MeetupFinder" do
      MeetupFinder.should_receive(:meetups_for).with(@user)
      @user.refresh_meetups!
    end

    context "no meetups to start" do
      before :each do
        @user.user_meetups.destroy
      end

      context "no meetups found" do
        before do
          MeetupFinder.should_receive(:meetups_for).and_return([])
        end
        it "should not have meetups" do
          @user.refresh_meetups!
          @user.user_meetups.should be_empty
        end
      end

      context "some meetups" do
        before do
          user_meetups = FactoryGirl.create_list(:user_meetup, 4, user: @user)
          @meetups = user_meetups.map(&:meetup)
          MeetupFinder.should_receive(:meetups_for).and_return(user_meetups)
        end

        it "should have the meetups" do
          @user.refresh_meetups!
          @meetups.each {|m| @user.meetups.should include(m) }
        end
      end
    end

    context "some meetups already" do
      # not sure these tests are 100% of what's needed, but whatever

      before :all do
        @user = FactoryGirl.create(:user, :with_meetups)
      end

      it "should replace the list with a new one" do
        serials = @user.user_meetups.map(&:id)

        user_meetups = FactoryGirl.create_list(:user_meetup, 4, user: @user)
        MeetupFinder.should_receive(:meetups_for).and_return(user_meetups)

        @user.refresh_meetups!

        new_serials = @user.user_meetups.map(&:id)

        # no overlap (all new serials)
        (serials & new_serials).should == []
      end
    end
  end

  it "should have a name" do
    user = FactoryGirl.create(:user)
    user.name.should be_present
  end

  describe "#display_name" do
    it "should default to the user's name" do
      user = FactoryGirl.create(:user)
      user.display_name.should == user.name
    end
  end

end
