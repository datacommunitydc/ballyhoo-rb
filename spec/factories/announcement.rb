FactoryGirl.define do
    factory :announcement do
        user
        meetup
        status "Visible"
        order 10
        message "Lorem Ipsum is hiring!"
        url "http://example.com"
    end
end
