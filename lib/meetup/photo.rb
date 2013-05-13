module MeetupApi
  class Photo
    include Virtus

    attribute :id, Integer
    attribute :link, String
    attribute :highres_link, String
    attribute :thumb_link, String

    def self.build_from_api_hash(h)
      Photo.new(
        id: h.photo_id,
        link: h.photo_link,
        highres_link: h.highres_link,
        thumb_link: h.thumb_link
      )
    end
  end
end
