FactoryGirl.define do
  factory :announcement do
    user
    meetup
    sequence(:message) {|n| "Fake message #{n}" }
  end
end
