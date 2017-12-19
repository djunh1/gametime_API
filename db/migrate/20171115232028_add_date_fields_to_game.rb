class AddDateFieldsToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :start_time, :time
    add_column :games, :duration, :decimal
    add_column :games, :date_single_game, :datetime
  end
end
