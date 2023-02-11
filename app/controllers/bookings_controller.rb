class BookingsController < ApplicationController
  # before_action :authenticate_user!

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
    @booking.user = current_user
    @booking.venue = Venue.find(params[:venue_id])
    if @booking.save!
      # redirect_to venue_path(@booking.venue), notice: 'Booking confirmed' #to do redirected to users show page
      redirect_to booking_path(@booking), notice: 'Booking confirmed'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
