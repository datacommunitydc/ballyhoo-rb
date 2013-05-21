require 'spec_helper'

describe AnnouncementsController do
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

  describe "get index" do
    it "should assign a set of announcements" do
      get :index, meetup_id: @meetup.id
      anns = assigns(:announcements)
      anns.should == @announcements
      @announcements.each do |ann|
        response.body.should include(ann.message)
      end
    end

    context "as json" do
      it "should render json for the announcements" do
        get :index, meetup_id: @meetup.id, format: :json
        response.body.should == @announcements.to_json
      end
    end
  end

  describe "get new" do
    it "renders an input form" do
      get :new, meetup_id: @meetup.id
      assigns(:meetup).should == @meetup
    end
  end

  describe "post create" do
    it "creates an announcement" do
      @msg = 'foo'
      ->{
        post :create,
          meetup_id: @meetup.id,
          announcement: {
            message: @msg
          }
      }.should change(Announcement, :count).by(1)

      ann = assigns(:announcement)
      ann.should_not be_nil
      ann.message.should == @msg
    end
  end
end
