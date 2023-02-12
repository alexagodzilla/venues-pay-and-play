class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @review = Review.new
  end

  def new
    @venue = Venue.find(params[:venue_id])
    @user = current_user
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.confirmed = true
    @booking.user = current_user
    @booking.venue = Venue.find(params[:venue_id])
    if @booking.save!
      # to do: redirect to user home page
      redirect_to booking_path(@booking), notice: 'Booking confirmed'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :confirmed)
  end
end
