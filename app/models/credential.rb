# == Schema Information
# Schema version: 20130407153747
#
# Table name: credentials
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  remote_uid :string(255)
#  kind       :string(255)
#  value      :string(255)
#  expires_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

# Credentials store extra credentials we get from auth providers. For
# example, meetup returns a token and refresh token as part of
# authorization that we can later use to do things on behalf of the user
class Credential < ActiveRecord::Base
end
