class RenameTypeColumn < ActiveRecord::Migration
  def change
  	rename_column :calendars, :type, :reservation_type
  end
end
