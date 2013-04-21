class UserMeetup < ActiveRecord::Base
    attr_accessor :user_id, :meetup_id, :admin

    belongs_to :user, class_name:"User"
    belongs_to :meetup, class_name:"Meetup"

    validates :user_id, presence:true
    validates :meetup_id, presence:true
end
