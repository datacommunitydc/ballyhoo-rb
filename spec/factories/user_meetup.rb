FactoryGirl.define do
  factory :user_meetup do
    user
    meetup

    factory :admin do
      admin true
    end
  end
end

