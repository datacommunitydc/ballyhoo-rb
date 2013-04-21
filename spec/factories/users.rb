# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "fake_email#{n}@example.com" }

    factory :josh do
      email "josh@example.com"
    end
  end

  factory :meetup do
    sequence(:name) { |n| "Meetup #{n}" }
    sequence(:url_name) { |n| "Meetup-#{n}" }
    announcements_enabled false
    anon_view_enabled false
  end

  factory :user_meetup do
    user
    meetup

    factory :admin do
      admin true
    end
  end
end
