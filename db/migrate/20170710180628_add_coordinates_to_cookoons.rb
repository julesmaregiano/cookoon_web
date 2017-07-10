class AddCoordinatesToCookoons < ActiveRecord::Migration[5.1]
  def change
    add_column :cookoons, :latitude, :float
    add_column :cookoons, :longitude, :float
  end
end
