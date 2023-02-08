class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @venue = Venue.find(params[:venue_id])
    if @review.save
      redirect_to venue_path(@venue), notice: 'Review was successfully created'
    else
      render 'venues/show', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
