class SessionsController < ApplicationController
  def index
  end

  def new
    redirect_to '/auth/meetup'
  end

  def create
    Rails.logger.debug("Auth Hash!!")
    Rails.logger.debug(auth_hash)
    #@user = User.find_or_create_from_auth_hash(auth_hash)
    #self.current_user = @user
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
