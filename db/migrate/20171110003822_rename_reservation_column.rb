class RenameReservationColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :reservations_id, :reservation_id
  end
end
