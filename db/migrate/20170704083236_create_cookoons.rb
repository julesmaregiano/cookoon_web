class CreateCookoons < ActiveRecord::Migration[5.1]
  def change
    create_table :cookoons do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :surface
      t.monetize :price
      t.string :address
      t.string :capacity

      t.timestamps
    end
  end
end
