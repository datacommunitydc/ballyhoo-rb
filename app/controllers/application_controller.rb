class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :login_required

  protected
    def login_required
      # TODO refactor to something that stores the path to redirect them back to
      redirect_to login_path unless current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id])
    end
    helper_method :current_user

    def current_user=(new_user)
      if new_user
        session[:user_id] = new_user.id
        @current_user = new_user
        Thread.current[:current_user] = new_user
      else
        session[:user_id] = nil
        @current_user = false
        Thread.current[:current_user] = nil
      end
    end
end
