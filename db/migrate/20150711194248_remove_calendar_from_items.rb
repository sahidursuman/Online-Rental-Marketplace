class RemoveCalendarFromItems < ActiveRecord::Migration
  def change
  	remove_column :items, :available_from
  	remove_column :items, :available_to
  end
end
