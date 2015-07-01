class DropItemItamesTable < ActiveRecord::Migration
  def change
  	drop_table :item_images
  end
end
