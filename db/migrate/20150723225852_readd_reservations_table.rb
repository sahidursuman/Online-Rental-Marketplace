class ReaddReservationsTable < ActiveRecord::Migration
  def change
  	create_table :reservations do |t|
      t.references :item, index: true
      t.integer :lender_id
      t.integer :lent_id
      t.datetime :borrow_date
      t.datetime :due_date
      t.string :request_status

      t.timestamps null: false
    end
    add_foreign_key :reservations, :items
    add_index :reservations, :lender_id
    add_index :reservations, :lent_id
    add_index :reservations, [:item_id, :lender_id, :lent_id], unique: true
  end
end
