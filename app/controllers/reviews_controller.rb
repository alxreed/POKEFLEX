class ReviewsController < ApplicationController

  def index
    @reviews = policy_scope(Review).order(created_at: :desc)
  end

  def show
  end

  def new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @review = Review.new
    authorize @review
  end
  
  def create
    # a voir
    @pokemon = Pokemon.find(params[:pokemon_id])
    @review = Review.new(review_params)
    @review.user = current_user
    authorize @review
    @review.pokemon = @pokemon
    if @review.save
      redirect_to pokemon_path(@pokemon)
    else
      render "pokemons/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end