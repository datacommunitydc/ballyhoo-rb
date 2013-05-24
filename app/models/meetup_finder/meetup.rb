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

module MeetupFinder
  class Meetup
    attr_accessor :user
    def initialize(user, options)
      @user    = user
      @options = options
    end

    def user_meetups
      raw = MeetupApi::Group.find_all_for_user(meetup_id, meetup_token)
      meetup_groups = Hashie::Mash.new(raw).results.map{|gh| MeetupApi::Group.build_from_api_hash(gh) }
      meetups = meetup_groups.map{|g| ::Meetup.build_from_api(g) }
      meetups.map{|m| UserMeetup.new( user: user, meetup: m ) }
    end

    def meetup_id
      token_credential.remote_uid
    end
    def meetup_token
      token_credential.value
    end

    def token_credential
      @cred ||= begin
                  cs = @user.credentials.where(provider: 'meetup')
                  cs.where(kind: 'token').last
                end
    end
  end
end
