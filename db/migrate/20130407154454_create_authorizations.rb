class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.string :provider
      t.string :remote_uid
      t.boolean :valid

      t.timestamps
    end
  end
end
