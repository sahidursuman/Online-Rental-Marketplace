class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.references :item, index: true
      t.datetime :available_from
      t.datetime :available_to

      t.timestamps null: false
    end
    add_foreign_key :calendars, :items
  end
end
