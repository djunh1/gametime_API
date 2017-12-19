class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :game_type
      t.string :rink_type
      t.integer :accomodate
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_skate_sharpen
      t.boolean :is_outdoors
      t.integer :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
