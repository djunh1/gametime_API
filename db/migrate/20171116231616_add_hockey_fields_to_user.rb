class AddHockeyFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :player_age, :integer
    add_column :users, :is_rink, :boolean, :default => false
    add_column :users, :position, :string
  end
end
