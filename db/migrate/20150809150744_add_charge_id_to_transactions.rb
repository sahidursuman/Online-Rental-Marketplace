class AddChargeIdToTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :charge_id, :string 
  end
end
