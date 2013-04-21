module MeetupFinder
  def self.default_strategy
    :meetup
  end

  def self.meetups_for(user, options = {})
    # Lookup with appropriate strategy
    klass = "MeetupFinder::#{default_strategy.to_s.camelize}".constantize
    klass.new(user, options).meetups
  end
end
