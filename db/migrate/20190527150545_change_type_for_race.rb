class ChangeTypeForRace < ActiveRecord::Migration[5.2]
  def change
    rename_column :races, :type, :category
  end
end
