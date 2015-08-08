class ChangeLendingPriceTypeBackToDecimal < ActiveRecord::Migration
  def change
  	 change_column :items, :lending_price, :decimal
  end
end
