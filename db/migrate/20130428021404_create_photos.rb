class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :photoable_id
      t.string :photoable_type
      t.string :url
      t.integer :width
      t.integer :height
      t.string :kind
      t.string :label

      t.timestamps
    end
  end
end
