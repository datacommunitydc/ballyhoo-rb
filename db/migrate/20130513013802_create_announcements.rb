class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.integer :meetup_id
      t.integer :user_id
      t.string :status
      t.integer :display_order
      t.string :announcer_name
      t.string :message
      t.string :url

      t.timestamps
    end
  end
end
