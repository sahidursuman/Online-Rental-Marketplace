class ChangeLendingPriceTypeInItemsTable < ActiveRecord::Migration
  def change
  	change_column :items, :lending_price, :string
  end
end
