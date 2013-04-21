class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_table :user_meetups do |t|
      t.integer :user_id
      t.integer :meetup_id
      t.boolean :admin

      t.timestamps
    end
  end
end
