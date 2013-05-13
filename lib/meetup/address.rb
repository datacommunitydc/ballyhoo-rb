module MeetupApi
  class Address
    include Virtus

    attribute :city,    String
    attribute :state,   String
    attribute :zip,     String
    attribute :country, String
  end
end
