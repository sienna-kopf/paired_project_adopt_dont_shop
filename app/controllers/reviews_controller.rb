class ReviewsController < ApplicationController
  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    redirect_to "/shelters/#{review.shelter_id}"
  end

  def new
   @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    @review = shelter.reviews.create(review_params)

    while !@review.save
      flash[:alert] = "Review not created. Missing information."
      return redirect_to "/shelters/#{shelter.id}/new"
    end

    redirect_to "/shelters/#{shelter.id}"
  end

  private

  def review_params
    params.permit(:image, :content, :title, :rating)
  end
end
