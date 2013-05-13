# == Schema Information
# Schema version: 20130513013802
#
# Table name: announcements
#
#  id             :integer          not null, primary key
#  meetup_id      :integer
#  user_id        :integer
#  status         :string(255)
#  display_order  :integer
#  announcer_name :string(255)
#  message        :string(255)
#  url            :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Announcement do
  describe "status scopes" do
    before :all do
      @queued   = FactoryGirl.create_list(:announcement, 3, status: 'queued')
      @visible  = FactoryGirl.create_list(:announcement, 3, status: 'visible')
      @archived = FactoryGirl.create_list(:announcement, 3, status: 'archived')
    end

    it "returns queued for queued" do
      Announcement.queued.to_a.should == @queued
    end

    it "returns visible for visible" do
      Announcement.visible.to_a.should == @visible
    end

    it "returns archived for archived" do
      Announcement.archived.to_a.should == @archived
    end
  end
end
