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

    def self.build_from_api_hash(h)
      Group.new(
        id: h.id, 
        name: h.name,
        urlname: h.urlname,
        description: h.description,
        coord: Coord.new(lat: h.lat, lon: h.lon),
        visibility: h.visibility,
        organizer: Member.new(id: h.organizer.member_id, name: h.organizer.name),
        link: h.link,
        location: Address.new(city: h.city, state: h.state, country: h.country),
        join_mode: h.join_mode,
        who: h.who,
        category: Category.build_from_api_hash(h.category),
        created: Time.at(h.created.to_i / 1000),
        rating: h.rating,
        member_count: h.members,
        group_photo: Photo.build_from_api_hash(h.group_photo),
        topics: h.topics.map{|t| Topic.build_from_api_hash(t) }
      )
    end
  end
end
