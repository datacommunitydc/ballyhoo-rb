class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name
      t.string :url_name
      t.boolean :announcements_enabled
      t.boolean :anon_view_enabled
      t.string :logo_url

      t.timestamps
    end
  end
end
