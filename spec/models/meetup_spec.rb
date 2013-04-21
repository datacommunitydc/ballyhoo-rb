# == Schema Information
# Schema version: 20130421120500
#
# Table name: meetups
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  url_name              :string(255)
#  announcements_enabled :boolean
#  anon_view_enabled     :boolean
#  logo_url              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  meetup_ident          :integer
#  photo_url             :string(255)
#

require 'spec_helper'

describe Meetup do

    before { @meetup = FactoryGirl.create(:meetup) }

    subject { @meetup }

    it { should respond_to(:name) }
    it { should respond_to(:url_name) }
    it { should respond_to(:announcements_enabled) }
    it { should respond_to(:anon_view_enabled) }
    it { should respond_to(:photo_url) }
    it { should respond_to(:users) }

end
