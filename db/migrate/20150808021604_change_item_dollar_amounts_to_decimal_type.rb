class ChangeItemDollarAmountsToDecimalType < ActiveRecord::Migration
  def change
  	  	change_column :items, :value, :decimal
  end
end
