module MeetupApi
  class Group
    include Virtus

    attribute :id, Integer
    attribute :name, String
    attribute :urlname, String
    attribute :description, String
    attribute :created, Time

    attribute :who, String # kind of people

    attribute :coord, Coord
    attribute :organizer, Member
    attribute :link, String
    attribute :location, Address
    attribute :category, Category
    attribute :group_photo, Photo

    attribute :member_count, Integer
    attribute :rating, Float
    attribute :join_mode, String
    attribute :visibility, String

    def self.find_all_for_user(member_id, token)
      HTTParty.get("https://api.meetup.com/2/groups.json?member_id=10624849&access_token=#{token}")
    end

    def self.build_from_api_hash(h)
      Group.new(
        id: h.id, 
        name: h.name,
        created: Time.at(h.created.to_i / 1000),
        description: h.description,
        join_mode: h.join_mode,
        link: h.link,
        member_count: h.members,
        rating: h.rating,
        urlname: h.urlname,
        visibility: h.visibility,
        who: h.who,
        topics: h.topics.map{|t| Topic.build_from_api_hash(t) },
        category: Category.build_from_api_hash(h.category),
        coord: Coord.new(lat: h.lat, lon: h.lon),
        group_photo: h.group_photo ? Photo.build_from_api_hash(h.group_photo) : nil,
        location: Address.new(city: h.city, state: h.state, country: h.country),
        organizer: Member.new(id: h.organizer.member_id, name: h.organizer.name),
      )
    end
  end
end
