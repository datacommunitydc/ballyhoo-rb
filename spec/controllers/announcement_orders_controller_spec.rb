require 'spec_helper'

describe AnnouncementOrdersController do
  render_views

  before :all do
    @meetup        = FactoryGirl.create(:meetup)
    @announcements = FactoryGirl.create_list(:announcement, 5, meetup: @meetup)
    @other_meetup  = FactoryGirl.create(:meetup)
    @other_anns    = FactoryGirl.create_list(:announcement, 5, meetup: @other_meetup)
  end

  before :each do
    controller.send('current_user=', FactoryGirl.create(:user))
  end

  describe "routing" do
    it "provides the proper path helper" do
      path = controller.edit_meetup_announcement_order_path(1)
      path.should == "/meetups/1/announcement_order/edit"
    end
  end

  describe "get edit" do
    it "allows editing the announcement order" do
      get :edit, meetup_id: @meetup.id
      assigns(:announcements).should == @announcements
    end
  end
end
