module UserInteractor
  class MeetupUserFactory
    attr_accessor :auth_hash, :user

    def initialize(auth_hash)
      @auth_hash = auth_hash
    end

    def find_or_create_user
      auth_set = Authorization.
        for_provider('meetup').
        with_remote_uid(meetup_uid)

      locate_user(auth_set.first)

      refresh_credentials

      user
    end

    private

      def locate_user(auth)
        @user = if auth
          auth.update_attributes(current: true)
          auth.user
        else
          create_user!
        end
      end

      def meetup_uid
        @meetup_uid ||= auth_hash['uid']
      end

      def create_user!
        user = User.new
        user.authorizations.build(
          provider: 'meetup',
          remote_uid: meetup_uid
        )
        user.save
        user
      end

      def refresh_credentials
        user.credentials.delete_all
        auth_hash['credentials'].slice(*%w{token refresh_token}).each do |k,v|
          user.credentials.create(
            provider: 'meetup',
            remote_uid: meetup_uid,
            kind: k,
            value: v,
            expires_at: Time.at(auth_hash['credentials']['expires_at'].to_i)
          )
        end
      end
  end
end