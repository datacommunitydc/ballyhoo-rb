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
end
