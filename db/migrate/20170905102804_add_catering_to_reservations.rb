class AddCateringToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :catering, :boolean, default: false
  end
end
