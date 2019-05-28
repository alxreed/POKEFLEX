class RentalsController < ApplicationController

  def index
    @rentals = Rental.all
  end

  def new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @rental = Rental.new
  end

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    # @user = User.find(params[:user_id])
    @rental = Rental.new(rental_params)
    @rental.pokemon = @pokemon
    @rental.user = @user
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

  def show
    @rental = Rental.find(params[:id])
  end

  def destroy
  end

  private

  def rental_params
    params.require(:rental).permit(:pokemon_id, :user_id, :starting_date, :ending_date)
  end

end
