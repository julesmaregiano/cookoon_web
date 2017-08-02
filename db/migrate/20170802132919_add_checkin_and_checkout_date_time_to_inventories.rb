class AddCheckinAndCheckoutDateTimeToInventories < ActiveRecord::Migration[5.1]
  def change
    add_column :inventories, :checkin_at, :datetime
    add_column :inventories, :checkout_at, :datetime
  end
end
