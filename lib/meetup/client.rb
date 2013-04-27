module MeetupApi
  class Client
    attr_accessor :bearer_token
    def initialize(options={})
      raise "Bearer token required" unless options[:bearer_token]
      @bearer_token = options[:bearer_token]
    end

    def make_request(method, uri, headers = {}, body = {})
      h = headers.merge({"Authorization"=>"bearer #{bearer_token}"})
      response = HTTParty.send(method, "https://api.meetup.com/#{uri}", headers: h, body: body)
      response.parsed_response
    end

    def find_groups_for_user(uid)
      resp = make_request(:get, "/2/groups?member_id=#{uid}")
      Hashie::Mash.new(resp).results.map {|g| Group.build_from_api_hash(g) }
    end
  end
end
