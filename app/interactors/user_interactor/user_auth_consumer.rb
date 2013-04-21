module UserInteractor
  class UserAuthConsumer
    attr_accessor :auth_hash

    def initialize(auth_hash)
      @auth_hash = auth_hash
    end

    def find_or_create_user
      if auth_hash && auth_provider
        begin
          klass = "UserInteractor::#{auth_provider.to_s.classify}UserFactory".constantize
          klass.new(auth_hash).find_or_create_user
        rescue NameError
          raise NoAuthProviderError.new("Unsupported Auth Provider")
        end
      else
        nil
      end
    end

    private

    def auth_provider
      auth_hash['provider']
    end

    class AuthError < StandardError; end
    class NoAuthProviderError < AuthError; end
  end
end
