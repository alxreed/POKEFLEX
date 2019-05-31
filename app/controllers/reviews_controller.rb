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
      respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'restaurants/show' }
        format.js  # <-- idem
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
