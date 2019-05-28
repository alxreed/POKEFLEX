class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
  def index
    if params["search"] == ""
      @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    else
      @pokemons = policy_scope(Pokemon.joins(:race)).where("races.name LIKE ?", "%#{params["search"]}%")
    end
  end

  def show
  end

  def new
    @pokemon = Pokemon.new
    authorize @pokemon
  end

  def create
    @race = Race.find(params[:pokemon][:race_id])
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.race = @race
    @pokemon.user = current_user
    authorize @pokemon
    if @pokemon.save
      set_urls
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
