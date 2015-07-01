class AddLendingStatusToItems < ActiveRecord::Migration
  def change
    add_column :items, :lending_status, :string
  end
end
