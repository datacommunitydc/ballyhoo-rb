FactoryGirl.define do
  factory :authorization do
    user

    factory :meetup_authorization do
      provider 'meetup'
    end
  end

end
