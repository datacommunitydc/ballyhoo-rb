class SessionsController < ApplicationController
  skip_before_filter :login_required
  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
  end

  def new
    redirect_to '/auth/meetup'
  end

  def create
    Rails.logger.debug("Auth Hash!!")
    Rails.logger.debug(auth_hash)
    user = UserInteractor.find_or_create_from_auth_hash(auth_hash)
    if user
      user.refresh_meetups!
      self.current_user = user
      redirect_to welcome_path
    else
      self.current_user = nil
      flash[:error] = "Invalid authentication!"
      redirect_to root_path
    end
  end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end
end
