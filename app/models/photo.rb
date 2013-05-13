# == Schema Information
# Schema version: 20130428021404
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  photoable_id   :integer
#  photoable_type :string(255)
#  url            :string(255)
#  width          :integer
#  height         :integer
#  kind           :string(255)
#  label          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Photo < ActiveRecord::Base
  belongs_to :photoable, polymorphic: true
  scope :by_kind, ->(k){ where(kind: k) }
end
