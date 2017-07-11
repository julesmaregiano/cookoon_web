class AddTypeToCookoons < ActiveRecord::Migration[5.1]
  def change
    add_column :cookoons, :type, :string
  end
end
