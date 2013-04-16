# == Schema Information
# Schema version: 20130415025142
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
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

end
