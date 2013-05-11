require 'spec_helper'

describe Announcement do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:meetup) { FactoryGirl.create(:meetup) }

  before do
    # This code is wrong!
    @ann = Announcement.new(meetup_id: meetup.id, user_id: user.id, status: "Visible", order: 10,
        message: "Hiring rockstars!", url: "http://cnn.com")
  end

  subject { @ann }

  it { should respond_to(:meetup_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:status) }
  it { should respond_to(:order) }
  it { should respond_to(:message) }
  it { should respond_to(:url) }
end
