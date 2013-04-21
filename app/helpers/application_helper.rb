module ApplicationHelper
  def login_path
    if Rails.env == 'development'
      '/auth/developer'
    else
      '/auth/meetup'
    end
  end
end
