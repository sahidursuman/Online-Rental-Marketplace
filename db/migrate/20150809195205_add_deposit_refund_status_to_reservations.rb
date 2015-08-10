class AddDepositRefundStatusToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :deposit_refund, :string
  end
end
