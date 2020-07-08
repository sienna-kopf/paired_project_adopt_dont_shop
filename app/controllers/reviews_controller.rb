class ReviewsController < ApplicationController
  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

  def review_params
    params.permit(:image, :content, :title, :rating)
  end
end
