FactoryGirl.define do
  factory :meetup do
    sequence(:name) { |n| "Meetup #{n}" }
    sequence(:url_name) { |n| "meetup-#{n}" }
    announcements_enabled false
    anon_view_enabled false
  end
end
