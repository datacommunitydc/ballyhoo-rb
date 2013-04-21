# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "fake_email#{n}@example.com" }

    factory :josh do
      email "josh@example.com"
    end
  end
end
