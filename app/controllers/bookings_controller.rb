class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  def index
    @bookings = Booking.all
  end

  def show
    @review = Review.new
  end

  def new
    @venue = Venue.find(params[:venue_id])
    @user = current_user
    @booking = Booking.new
  end

  def create
    @venue = Venue.find(params[:venue_id])
    @booking = Booking.new(booking_params)
    @booking.confirmed = true
    @booking.user = current_user
    @booking.venue = Venue.find(params[:venue_id])
    if @booking.save
      redirect_to booking_path(@booking), notice: 'Booking confirmed'
    else
      render :new, status: :unprocessable_entity, locals: { venue: @venue }
    end
  end

  def edit; end

  def update
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking.destroy
    redirect_to root_path, notice: 'Booking deleted'
    # once user page done, redirect_to user_path, notice: 'Booking deleted'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :confirmed)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
