class ChangeReservationsIndex < ActiveRecord::Migration
  def change
  	remove_index :reservations, [:item_id, :lender_id, :lent_id]
  	add_index :reservations, [:item_id, :lender_id, :lent_id]
  end
end
