class AddTimeToCalendar < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :start_time, :time
  end
end
