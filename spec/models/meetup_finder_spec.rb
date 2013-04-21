require 'spec_helper'

describe MeetupFinder do
  #Intended API:
  #  all_metups = MeetupFinder.meetups_for(user)
  #  organizing = MeetupFinder.meetups_for(user, organizing: true)
  #  all_metups = MeetupFinder.meetups_for(user, strategy: :development)
  #  all_metups = MeetupFinder.meetups_for(user, strategy: :meetup)

  before :all do
    @user_with_no_meetups = FactoryGirl.create(:user)
  end

  describe "lookup strategies" do
    context ":development strategy" do
      before :each do
        MeetupFinder.stub(:default_strategy).and_return(:development)
      end

      it "uses the development strategy" do
        strategy = double("MeetupFinder::Development")
        strategy.should_receive(:meetups)
        MeetupFinder::Development.
          should_receive(:new).
          once.
          and_return(strategy)
        MeetupFinder.meetups_for(@user_with_no_meetups)
      end
    end

    context ":meetup strategy" do
      # no setup because meetup is default

      it "uses the meetup strategy" do
        strategy = double("MeetupFinder::Metup")
        strategy.should_receive(:meetups)
        MeetupFinder::Meetup.
          should_receive(:new).
          once.
          and_return(strategy)
        MeetupFinder.meetups_for(@user_with_no_meetups)
      end
    end

    it "passes on options to the lookup strategy" do
      strategy = double("MeetupFinder::Metup")
      strategy.should_receive(:meetups)
      MeetupFinder::Meetup.
        should_receive(:new).
        with(@user_with_no_meetups, foo: :bar).
        once.
        and_return(strategy)
      MeetupFinder.meetups_for(@user_with_no_meetups, foo: :bar)
    end
  end

  context "looking up the available meetups to a user" do

      it "finds no meetups when there are none for a user" do
        MeetupFinder.meetups_for(@user_with_no_meetups)
      end

  end
  it "looks up the meetups where the user is an organizer"

  it "has a default strategy that defaults to :meetup" do
    MeetupFinder.default_strategy.should == :meetup
  end


end
