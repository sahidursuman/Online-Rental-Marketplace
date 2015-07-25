class AddCalendarTypeToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :type, :string
    change_column :calendars, :available_from, :datetime, null: true
    change_column :calendars, :available_to, :datetime, null: true
  end
end
