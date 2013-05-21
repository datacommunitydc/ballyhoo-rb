class AnnouncementsController < ApplicationController
  def index
    @announcements = meetup.announcements
  end

  def new
    meetup
  end

  def create
    @announcement = meetup.announcements.build(announcement_params)
    @announcement.user = current_user

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to meetup_announcements_path(@meetup), notice: 'Announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement }
      else
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

    def meetup
      @meetup ||= Meetup.find_by_id(params[:meetup_id])
    end
    helper_method :meetup

    def announcement_params
      params.require(:announcement).permit(:message, :announcer_name, :url)
    end
end
