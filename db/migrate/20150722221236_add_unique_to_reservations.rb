class AddUniqueToReservations < ActiveRecord::Migration
  def change
  	add_index :reservations, [:item_id, :lender_id, :lent_id], unique: true
  end
end
