# == Schema Information
# Schema version: 20130421120500
#
# Table name: user_meetups
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  meetup_id  :integer
#  admin      :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe UserMeetup do
  pending "add some examples to (or delete) #{__FILE__}"
end
