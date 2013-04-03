class MeetupCredentials
  class << self
    def credentials_from_yaml
      @credentials_from_yaml ||= begin
                                   credentials = YAML.load(File.read(File.join(File.dirname(__FILE__), %w{.. meetup_credentials.yml})))
                                   {key: credentials['meetup']['key'], secret: credentials['meetup']['secret']}
                                 end
    end

    def key
      @key ||= ENV['MEETUP_KEY'] || credentials_from_yaml[:key]
    end
    def secret
      @secret ||= ENV['MEETUP_SECRET'] || credentials_from_yaml[:secret]
    end
  end
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :meetup, MeetupCredentials.key, MeetupCredentials.secret
end
