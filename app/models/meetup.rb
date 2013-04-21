class Meetup < ActiveRecord::Base
    attr_accessor :name, :url_name, :announcements_enabled, :anon_view_enabled, :photo_url

    has_many :users, through: :user_meetup 
end
