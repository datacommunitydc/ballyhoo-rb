class AddExtraDataToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :extra_data, :text
  end
end
