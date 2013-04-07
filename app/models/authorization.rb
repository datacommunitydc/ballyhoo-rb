# == Schema Information
# Schema version: 20130407154454
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  remote_uid :string(255)
#  valid      :boolean
#  created_at :datetime
#  updated_at :datetime
#

# Authorizations essentially link users in our system to remote users
# from other systems (like meetup.com)
class Authorization < ActiveRecord::Base
end
