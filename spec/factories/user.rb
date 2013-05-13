# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "fake_email#{n}@example.com" }
    sequence(:name) { |n| "fake name #{n}" }

    factory :josh do
      email "josh@example.com"
    end
    factory :harlan do
      email "harlan@example.com"
    end

    trait :with_meetup_auth do
      ignore do
        remote_uid 123
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create(:meetup_authorization, user: user, remote_uid: evaluator.remote_uid)
      end
    end

    trait :with_meetups do
      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:user_meetup, 3, user: user)
      end
    end
  end
end
