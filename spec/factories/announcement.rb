FactoryGirl.define do
  factory :announcement do
    user
    meetup
    sequence(:message) {|n| "Fake message #{n}" }
    status Announcement::INITIAL_STATUS
  end
end
