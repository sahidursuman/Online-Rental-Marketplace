class AddListingStatusToItems < ActiveRecord::Migration
  def change
    add_column :items, :listing_status, :string
  end
end
