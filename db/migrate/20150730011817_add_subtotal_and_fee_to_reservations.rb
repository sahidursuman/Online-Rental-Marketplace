class AddSubtotalAndFeeToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :subtotal, :string
    add_column :reservations, :fee, :string
  end
end
