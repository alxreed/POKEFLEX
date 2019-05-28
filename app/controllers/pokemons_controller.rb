class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
  def index
    @pokemons = policy_scope(Pokemon).order(created_at: :desc)
  end

  def show
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    race_id = params[:pokemon][:ingredient_id]
    @race = Race.find(params[:pokemon][:race_id]) if race_id
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.race = @race
    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    @pokemon.update(pokemon_params)
    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :edit
    end
  end
  
  def destroy
    @pokemon.destroy
  end
  
  private
  
  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
    authorize @pokemon
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :level, :price, :race_id)
  end
end
