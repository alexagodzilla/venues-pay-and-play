class ReviewsController < ApplicationController
  before_action :set_review, only: %i[edit update destroy]

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    if @review.save
      redirect_to venue_path(@venue), notice: 'Review was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @review.update(review_params)
    if @review.save
      redirect_to booking_path(@review.booking)
      # unsure about the above line
    else
      redirect_to 'bookings/show', notice: "Review added."
    end
  end

  def destroy
    @review.delete
    redirect_to booking_path(@review.booking), notice: "Review deleted."
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end

# index/show - we show reviews on bookings show
# new - we create a new review on the booking show
