module UserInteractor
  class UserAuthConsumer
    attr_accessor :auth_hash

    def initialize(auth_hash)
      @auth_hash = auth_hash
    end

    def find_or_create_user
      case auth_provider
      when 'meetup'
        find_or_create_meetup_user
      else
        raise AuthException.new("unsupported auth provider")
      end
    end

    private

    def find_or_create_meetup_user
      Credential.for_provider(:meetup).with_
    end

    def auth_provider
      auth_hash['provider']
    end

    class AuthException < StandardError; end
  end
end
