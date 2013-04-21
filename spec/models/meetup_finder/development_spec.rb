require 'spec_helper'

describe MeetupFinder::Development do
  it "is a big sham"

  describe "behavior for Josh" do
    before :all do
      @josh = FactoryGirl.create(:josh)
    end

    it "gives back some meetups for \"josh\"" do
      meetups = MeetupFinder::Development.new(@josh, {}).user_meetups
      meetups.size.should == 3
    end
  end
end
