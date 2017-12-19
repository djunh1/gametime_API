class RemoveSchedulingFieldsFromGame < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :date_single_game, :datetime
    remove_column :games, :is_monday, :boolean
    remove_column :games, :is_tuesday, :boolean
    remove_column :games, :is_wednesday, :boolean
    remove_column :games, :is_thursday, :boolean
    remove_column :games, :is_friday, :boolean
    remove_column :games, :is_saturday, :boolean
    remove_column :games, :is_sunday, :boolean
  end
end
