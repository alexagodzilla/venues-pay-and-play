class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :set_venue, only: %i[new create]

  def index
    @bookings = Booking.all
  end

  def show
    @review = Review.new
    @marker = []
    set_markers
    @marker << @markers.find { |m| m[:lat] == @booking.venue.latitude && m[:lng] == @booking.venue.longitude }
  end

  def new
    @user = current_user
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.confirmed = true
    @booking.user = current_user
    @booking.venue = @venue
    flash.now[:error] = "Venue already booked for this date - please try again"
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
    redirect_to profile_path, notice: 'Booking deleted'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :confirmed)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def set_markers
    @venues = Venue.all
    @markers = @venues.geocoded.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        info_window_html: render_to_string(partial: "venues/popup", locals: { venue: venue }),
        marker_html: render_to_string(partial: "venues/marker")
      }
    end
  end
end
