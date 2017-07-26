class AddHostOptionsToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :cleaning, :boolean, default: false
    add_column :reservations, :janitor, :boolean, default: false
  end
end
