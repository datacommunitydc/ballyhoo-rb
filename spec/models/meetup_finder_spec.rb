require 'spec_helper'

describe MeetupFinder do
  before :all do
    @user_with_no_meetups = FactoryGirl.create(:user)
  end

  describe "#default_strategy" do
    it "has a default strategy that defaults to :meetup" do
      MeetupFinder.default_strategy.should == :meetup
    end

    context "changing it" do
      it "can be changed" do
        MeetupFinder.default_strategy = :foo
        MeetupFinder.default_strategy.should == :foo
      end

      after :all do
        MeetupFinder.instance_variable_set('@default_strategy', nil)
      end
    end
  end

  describe "lookup strategies" do
    context ":development strategy" do
      before :all do
        MeetupFinder.default_strategy = :development
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
      before :all do
        MeetupFinder.default_strategy = :meetup
      end

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



end
