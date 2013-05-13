module MeetupApi
  class Member
    include Virtus

    attribute :id, Integer
    attribute :name, String
  end
end
