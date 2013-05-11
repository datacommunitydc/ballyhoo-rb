class MeetupController < ApplicationController
  def view
    @meetup = Meetup.find_by_url_name(params[:url_name])
    @announcements = @meetup.announcements
  end
end