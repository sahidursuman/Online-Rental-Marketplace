class AddRequestedToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :requested, :string
  end
end
