module MeetupApi
  class Topic
    include Virtus

    attribute :id, Integer
    attribute :urlkey, String
    attribute :name, String

    def self.build_from_api_hash(h)
      Topic.new(
        id: h.id,
        urlkey: h.urlkey,
        name: h.name
      )
    end
  end
end
