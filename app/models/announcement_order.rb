class AnnouncementOrder
  include Virtus
  extend  ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :meetup,     Meetup
  attribute :enabled,    Boolean
  attribute :allow_anon, Boolean
end
