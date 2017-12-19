class AddRosterspotsToCalendar < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :roster_spots, :integer
  end
end
