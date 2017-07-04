class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :cookoon, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :date
      t.integer :duration

      t.timestamps
    end
  end
end
