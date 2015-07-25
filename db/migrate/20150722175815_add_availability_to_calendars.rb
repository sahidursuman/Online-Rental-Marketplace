class AddAvailabilityToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :availability, :string
  end
end
