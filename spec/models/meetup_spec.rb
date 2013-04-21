require 'spec_helper'

describe Meetup do

    before { @meetup = FactoryGirl.create(:meetup) }

    subject { @meetup }

    it { should respond_to(:name) }
    it { should respond_to(:url_name) }
    it { should respond_to(:announcements_enabled) }
    it { should respond_to(:anon_view_enabled) }
    it { should respond_to(:photo_url) }
    it { should respond_to(:users) }

end
