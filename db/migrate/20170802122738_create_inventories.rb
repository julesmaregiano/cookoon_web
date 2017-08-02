class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.references :reservation, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
