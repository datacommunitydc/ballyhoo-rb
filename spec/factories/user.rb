# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "fake_email#{n}@example.com" }

    factory :josh do
      email "josh@example.com"
    end

    factory :user_with_meetups do
      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:user_meetup, 3, user: user)
      end
    end
  end
end
