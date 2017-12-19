class AddInstantToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :instant, :integer, default: 1
  end
end
