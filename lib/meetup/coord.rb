module MeetupApi
  class Coord
    include Virtus

    attribute :lat, Float
    attribute :lon, Float
  end
end
