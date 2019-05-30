class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
  def index
    p params
    if params[:search].nil?
      @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    else
      @pokemons = policy_scope(Pokemon.joins(:race)).where("races.name ILIKE ?", params[:search])
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
    redirect_to user_path(@current_user)
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
