class ReviewsController < ApplicationController
  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    if !review.save
      flash[:errors] = review.errors.full_messages
      return redirect_to "/shelters/reviews/#{review.id}/edit"
    end
    redirect_to "/shelters/#{review.shelter_id}"
  end

  def new
   @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    @review = shelter.reviews.new(review_params)

    if @review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = @review.errors.full_messages
      redirect_to "/shelters/#{shelter.id}/new"
    end
  end

  private

  def review_params
    params.permit(:image, :content, :title, :rating)
  end
end
