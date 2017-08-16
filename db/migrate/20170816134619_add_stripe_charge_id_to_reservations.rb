class AddStripeChargeIdToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :stripe_charge_id, :string
  end
end
