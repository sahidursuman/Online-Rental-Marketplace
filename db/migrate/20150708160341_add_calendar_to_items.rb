class AddCalendarToItems < ActiveRecord::Migration
  def change
    add_column :items, :available_from, :datetime
    add_column :items, :available_to, :datetime
  end
end
