module MeetupFinder
  class Development
    JOSH = "josh@example.com"

    attr_accessor :user, :options
    def initialize(user, options)
      @user    = user
      @options = options
    end

    def user_meetups
      case user.email
      when JOSH
        meetups_for_josh
      end
      # TODO
    end

    private

      def meetups_for_josh
        user_meetups = 3.times.map do |i|
          m = find_or_fake_meetup(
            name: "Josh's Fake Meetup #{i}",
            url_name: "joshs-fake-meetup-#{i}",
            meetup_ident: 1111 + i,
            photo_url: 'http://hhhold.com/200x300'
          )
          UserMeetup.new(
            user: user,
            meetup: m
          )
        end
        user_meetups.last.admin = true
        user_meetups
      end

      def find_or_fake_meetup(options)
        if m = Meetup.find_by_meetup_ident(options[:meetup_ident])
          m
        else
          Meetup.create(options)
        end
      end
  end
end
