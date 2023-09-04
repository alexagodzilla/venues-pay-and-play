class ReviewsController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @venue = @booking.venue
    @review = Review.new(review_params)
    @review.booking = @booking
    if @review.save!
      redirect_to venue_path(@venue), notice: 'Review was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @venue = @review.booking.venue
    @review.destroy
    redirect_to venue_path(@venue), notice: "Review deleted"
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
