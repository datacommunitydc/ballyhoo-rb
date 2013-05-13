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
  has_many :photos, as: :photoable
  has_many :announcements

  def self.build_from_api(g)
    Meetup.new(
      name: g.name,
      url_name: g.urlname,
      logo_url: g.group_photo.link,
      meetup_ident: g.id
    )
  end
end
