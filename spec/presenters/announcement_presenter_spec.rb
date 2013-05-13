require 'spec_helper'

describe AnnouncementPresenter do
  describe "#display_name" do
    it "should be the user's display name" do
      ann = AnnouncementPresenter.new FactoryGirl.create(:announcement)

      ann.display_name.should == ann.user.display_name
    end

    context "with an announcer_name" do
      it "should be overridden to the announcer_name" do
        @overridden = 'Some awesome name'
        ann = AnnouncementPresenter.new(
          FactoryGirl.create(:announcement, announcer_name: @overridden)
        )

        ann.display_name.should == @overridden
      end

      context "with wacky client data" do
      # Handle wacky data from client
        it 'should use the user\'s display_name if the announcer_name is ""' do
          @overridden = ""
          ann = AnnouncementPresenter.new(
            FactoryGirl.create(:announcement, announcer_name: @overridden)
          )

          ann.display_name.should == ann.user.display_name
        end
        it 'should use the user\'s display_name if the announcer_name is whitespace' do
          @overridden = " \n\n  \t"
          ann = AnnouncementPresenter.new(
            FactoryGirl.create(:announcement, announcer_name: @overridden)
          )

          ann.display_name.should == ann.user.display_name
        end
      end
    end
  end
end
