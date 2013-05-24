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

class Announcement < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :user

  STATUSES = %w{queued visible archived}
  INITIAL_STATUS = 'queued'
  validates_inclusion_of :status, in: STATUSES

  STATUSES.each do |sta|
    scope sta, ->{ where(status: sta) }
    define_method "#{sta}?" do
      self.status == sta
    end
  end

  scope :recent, ->{ order(created_at: :desc) }
  scope :for_meetup, ->(m){ where(meetup_id: m) }

  before_validation :set_default_status

  private

  def set_default_status
    self.status = INITIAL_STATUS unless status.present?
  end
end
