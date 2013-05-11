class Announcement < ActiveRecord::Base
    attr_accessor :message, :meetup_id, :status, :order, :url

    validates :user_id, presence: true
    validates :meetup_id, presence: true
    validates :order, presence: true

    validates :message, presence: true, length: { maximum: 200 }

    
    belongs_to :meetup
    belongs_to :user

    default_scope order: 'announcement.order'
end
