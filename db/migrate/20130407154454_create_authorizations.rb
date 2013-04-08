class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.string :provider
      t.string :remote_uid
      t.boolean :current

      t.timestamps
    end
  end
end
