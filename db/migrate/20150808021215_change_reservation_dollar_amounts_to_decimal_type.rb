class ChangeReservationDollarAmountsToDecimalType < ActiveRecord::Migration
  def change
  	change_column :reservations, :subtotal, :decimal
  	change_column :reservations, :fee, :decimal
  	change_column :reservations, :deposit, :decimal
  end
end
