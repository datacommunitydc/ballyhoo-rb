class AddMeetupIdentToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :meetup_ident, :integer
    add_column :meetups, :photo_url, :string
  end
end

