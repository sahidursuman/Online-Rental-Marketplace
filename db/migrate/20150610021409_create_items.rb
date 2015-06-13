class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, index: true, foreign_key: true
      t.text :item_name
      t.decimal :lending_price
      t.datetime :created_at
      t.datetime :updated_at
      t.string :category

      t.timestamps null: false
    end
  end
end
