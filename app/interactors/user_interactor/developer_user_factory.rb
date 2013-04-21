module UserInteractor
  class DeveloperUserFactory
    def initialize(auth_hash)
      @auth_hash = auth_hash
    end

    def find_or_create_user
      if u = User.find_by_email(email)
        u
      else
        User.create(email: email)
      end
    end

    private
      def email
        @auth_hash[:uid]
      end
  end
end

