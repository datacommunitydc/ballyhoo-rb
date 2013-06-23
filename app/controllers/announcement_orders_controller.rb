class AnnouncementOrdersController < ApplicationController
  def show
    @announcements = meetup.announcements
  end

  def edit
    @announcements = meetup.announcements
  end

  private

    def meetup
      @meetup ||= Meetup.find_by_id(params[:meetup_id])
    end
    helper_method :meetup
end
