class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.integer :user_id
      t.integer :meetup_id
      t.string :status
      t.float :order
      t.string :message
      t.string :url

      t.timestamps
    end
    add_index :announcements, [:user_id, :meetup_id]
    add_index :announcements, :meetup_id
  end
end
