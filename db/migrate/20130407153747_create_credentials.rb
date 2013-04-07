class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.integer :user_id
      t.string :provider
      t.string :remote_uid
      t.string :kind
      t.string :value
      t.datetime :expires_at

      t.timestamps
    end
  end
end
