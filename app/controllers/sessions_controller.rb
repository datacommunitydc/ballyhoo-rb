class SessionsController < ApplicationController
  skip_before_filter :login_required

  def index
  end

  def new
    redirect_to '/auth/meetup'
  end

  def create
    Rails.logger.debug("Auth Hash!!")
    Rails.logger.debug(auth_hash)
    @user = UserInteractor.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to welcome_path
  end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end
end
