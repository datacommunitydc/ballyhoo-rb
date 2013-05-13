FactoryGirl.define do
  factory :credential do
    user

    trait :for_meetup do
      provider 'meetup'
    end
  end
end
