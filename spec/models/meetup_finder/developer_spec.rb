require 'spec_helper'

describe MeetupFinder::Developer do
  #it "is a big sham"

  describe "behavior for Josh" do
    before :all do
      @josh = FactoryGirl.create(:josh)
    end

    it "gives back some meetups for josh" do
      meetups = MeetupFinder::Developer.new(@josh, {}).user_meetups
      meetups.size.should == 3
      meetups.all?{|m| m.is_a? UserMeetup }.should be_true
      meetups.detect{|m| m.admin == true }.should_not be_nil
    end
  end
end
