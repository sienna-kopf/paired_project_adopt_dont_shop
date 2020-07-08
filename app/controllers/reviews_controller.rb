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

  private

  def review_params
    params.permit(:image, :content, :title, :rating)
  end
end
