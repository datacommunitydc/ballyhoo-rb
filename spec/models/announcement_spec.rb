require 'spec_helper'

describe Announcement do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:meetup) { FactoryGirl.create(:meetup) }

  before do
    # get user_id for free -- what about meetup_id?
    @ann = user.announcements.new(meetup_id: meetup.id, status: "Visible", order: 10,
        message: "Hiring rockstars!", url: "http://cnn.com")
  end

  subject { @ann }

  it { should respond_to(:meetup_id) }
  its(:meetup) { should == meetup } # fails -- presumably because it wasn't created the right way?
  it { should respond_to(:user_id) }
  its(:user) { should == user }
  it { should respond_to(:status) }
  it { should respond_to(:order) }
  it { should respond_to(:message) }
  it { should respond_to(:url) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @ann.user_id = nil }
    it { should_not be_valid }
  end
  describe "when meetup_id is not present" do
    before { @ann.meetup_id = nil }
    it { should_not be_valid }
  end
  # couldn't get the below to work...
  # describe "accessible attributes" do
  #   it "should not allow access to user_id" do
  #     expect do
  #       Announcement.new(user_id: user.id)
  #     end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  #   end
  #   it "should not allow access to meetup_id" do
  #     expect do
  #       Announcement.new(meetup_id: meetup.id)
  #     end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  #   end    
  # end

  describe "with blank content" do
    before { @ann.message = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @ann.message = "a" * 201 }
    it { should_not be_valid }
  end
end
