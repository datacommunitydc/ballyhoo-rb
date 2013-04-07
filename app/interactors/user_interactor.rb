module UserInteractor
  def self.find_or_create_from_auth_hash(auth_hash)
    UserAuthConsumer.new(auth_hash).find_or_create_user
  end
end
