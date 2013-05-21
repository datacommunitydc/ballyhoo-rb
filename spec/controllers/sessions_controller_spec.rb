require 'spec_helper'

describe SessionsController do
  before :all do
    OmniAuth.config.add_mock(:meetup, {
      :uid => '12345',
      :info => {
        :name => 'Foo Bar',
        :photo_url => 'http://photo_url'
      },
      :extra => {
        :raw_info => {
          :link => 'http://profile_link'
        }
      }
    })
  end

  describe "get :create" do
    context "invalid auth" do
      it "redirects to login" do
        get :create, provider: :meetup
        response.should redirect_to(login_path)
      end
    end

    context "valid auth" do
      before :each do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:meetup]
        @user = FactoryGirl.create(:user)
        UserInteractor.stub(:find_or_create_from_auth_hash).and_return(@user)
      end
      it "refreshes meetups for the user with the auth strategy used" do
        @user.should_receive(:refresh_meetups!)
        get :create, provider: :meetup
      end
    end
  end
end
