class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title, null: true
      t.string :image
      t.references :item, index: true

      t.timestamps null: false
    end
    add_foreign_key :photos, :items
  end
end
