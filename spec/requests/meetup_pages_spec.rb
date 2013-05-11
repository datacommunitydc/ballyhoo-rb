require 'spec_helper'

describe "Meetup pages" do
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user, :with_meetups) }
    let!(:a1) { FactoryGirl.create(:annnouncement, user: user, meetup: user.meetups.first, content: "Foo", order: 10) }
    let!(:a2) { FactoryGirl.create(:annnouncement, user: user, meetup: user.meetups.first, content: "Bar", order: 5) }

    before { visit meetup_path(user.meetups.first.url_name) }

    it { should have_selector('title', text: user.meetups.first.name) }

    describe "announcements" do
      it { should have_content(m1.message) }
      it { should have_content(m2.message) }
    end
  end
end