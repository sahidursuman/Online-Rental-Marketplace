class AddDepositToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :deposit, :string
  end
end
