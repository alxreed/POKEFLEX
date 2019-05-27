class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :name
      t.string :photo
      t.string :type
      t.string :location

      t.timestamps
    end
  end
end
