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

class UserMeetup < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup

  validates :user_id,   presence: true
  validates :meetup_id, presence: true
end
