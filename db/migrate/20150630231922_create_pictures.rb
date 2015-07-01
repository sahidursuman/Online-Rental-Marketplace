class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :file_name
      t.references :item, index: true

      t.timestamps null: false
    end
    add_foreign_key :pictures, :items
  end
end
