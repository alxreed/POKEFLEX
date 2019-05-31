class AddColumnsToPokemons < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemons, :hp, :integer
    add_column :pokemons, :attack, :integer
    add_column :pokemons, :defense, :integer
    add_column :pokemons, :special_attack, :integer
    add_column :pokemons, :special_defense, :integer
    add_column :pokemons, :speed, :integer
    add_column :pokemons, :booked, :boolean, default: false
  end
end
