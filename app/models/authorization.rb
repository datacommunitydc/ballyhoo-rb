# == Schema Information
# Schema version: 20130427181838
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
#  extra_data :text
#

# Authorizations essentially link users in our system to remote users
# from other systems (like meetup.com)
class Authorization < ActiveRecord::Base

  serialize :extra_data

  scope :for_provider, ->(p) { where(provider: p) }
  scope :with_remote_uid, ->(uid) { where(remote_uid: uid) }
  scope :current, -> { where(current: true) }

  belongs_to :user

  def self.find_or_build(provider, remote_uid)
    if existing = Authorization.for_provider(provider).with_remote_uid(remote_uid).last
      existing.touch
      existing
    else
      Authorization.new(provider: provider,
                        remote_uid: remote_uid)
    end
  end
end
