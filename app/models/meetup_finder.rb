# should be used to update a user's meetup list on login
module MeetupFinder
  def self.default_strategy
    @default_strategy ||= :meetup
  end
  def self.default_strategy=(strategy)
    @default_strategy = strategy
  end

  def self.meetups_for(user, options = {})
    # Lookup with appropriate strategy
    klass = "MeetupFinder::#{default_strategy.to_s.camelize}".constantize
    klass.new(user, options).user_meetups
  end
end
