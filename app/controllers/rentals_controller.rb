class RentalsController < ApplicationController

  def index
    @rentals = policy_scope(Rental)
  end

  def show
    @rental = Rental.find(params[:id])
    authorize @rental
  end
  
  def new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @rental = Rental.new
    authorize @rental
  end

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @pokemon.update(booked: true)
    @pokemon.errors.full_messages
    @rental = Rental.new(rental_params.merge(pokemon: @pokemon, user: current_user))
    authorize @rental
    if @rental.save
      redirect_to rental_path(@rental)
    else
      redirect_to pokemon_path(@pokemon)
    end
  end

  def edit
  end

  def update
  end


  def destroy
  end

  private

  def rental_params
    params.require(:rental).permit(:pokemon_id, :user_id, :starting_date, :ending_date)
  end

end
