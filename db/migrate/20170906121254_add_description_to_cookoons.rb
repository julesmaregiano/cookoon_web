class AddDescriptionToCookoons < ActiveRecord::Migration[5.1]
  def change
    add_column :cookoons, :description, :text
  end
end
