class AddSlotToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :roster_spot, :integer, default: 1
  end
end
