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

class Meetup < ActiveRecord::Base
  has_many :users, through: :user_meetup
  has_many :announcements
end
