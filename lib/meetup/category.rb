module MeetupApi
  class Category
    include Virtus

    attribute :id, Integer
    attribute :name, String
    attribute :shortname, String

    def self.build_from_api_hash(h)
      Category.new(
        id: h.id,
        name: h.name,
        shortname: h.shortname
      )
    end
  end
end
