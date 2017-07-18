class CreateUserSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :user_searches do |t|
      t.references :user, foreign_key: true
      t.string :address
      t.datetime :date
      t.integer :number
      t.integer :duration

      t.timestamps
    end
  end
end
