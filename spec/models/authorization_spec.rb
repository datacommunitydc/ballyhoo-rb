# == Schema Information
# Schema version: 20130407154454
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  remote_uid :string(255)
#  current    :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Authorization do
  describe '#find_or_build' do
    before :all do
      @provider = 'foo'
      @remote_uid = '123'
    end

    context "building" do
      it "builds a new auth given proper info" do
        auth = Authorization.find_or_build(@provider, @remote_uid)
        auth.should_not be_nil
        auth.should be_new_record
        auth.provider.should == @provider
        auth.remote_uid.should == @remote_uid
      end
    end

    context "finding" do
      # TODO this before/after sucks. Clean it up.
      before :each do
        Timecop.freeze(Time.now)
        @existing_auth = Authorization.create(user_id: 1, provider: @provider, remote_uid: @remote_uid)
        Timecop.travel(1.hour.from_now)
        @auth = Authorization.find_or_build(@provider, @remote_uid)
      end
      after :each do
        Authorization.delete_all
        Timecop.return
      end

      it "returns a proper auth given that one exits" do
        @auth.should == @existing_auth
      end

      it "updates the updated_at when finding" do
        @auth.updated_at.to_i.should_not == @existing_auth.updated_at.to_i
        @auth.updated_at.to_i.should == Time.now.to_i
      end
    end
  end
end
