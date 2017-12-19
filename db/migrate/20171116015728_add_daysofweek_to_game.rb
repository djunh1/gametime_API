class AddDaysofweekToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :is_monday, :boolean
    add_column :games, :is_tuesday, :boolean
    add_column :games, :is_wednesday, :boolean
    add_column :games, :is_thursday, :boolean
    add_column :games, :is_friday, :boolean
    add_column :games, :is_saturday, :boolean
    add_column :games, :is_sunday, :boolean
  end
end
