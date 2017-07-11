class ChangeTypeToCategoryForCookoons < ActiveRecord::Migration[5.1]
  def change
    rename_column :cookoons, :type, :category
  end
end
