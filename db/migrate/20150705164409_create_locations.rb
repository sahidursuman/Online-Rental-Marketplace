class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street
      t.string :apartment, null: true
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.references :item, index: true

      t.timestamps null: false
    end
    add_foreign_key :locations, :items
  end
end
