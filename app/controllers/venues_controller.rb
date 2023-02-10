class VenuesController < ApplicationController
  before_action :set_venue, only: [:show]
  def index
    if params[:start].present? || params[:end].present?
      range = (params[:start].to_date..params[:end].to_date).to_a
      @venues = []
      Venue.all.each do |venue|
        venue.bookings.each do |booking|
          @venues << venue unless range.include?(booking.start_date || booking.end_date)
        end
      end
      @venues
    else
      @venues = Venue.all
    end
  end

  def show
    # @booking = Booking.find(params[:booking_id])
    @venue = Venue.find(params[:id])
    # @booking = Booking.new
    # @booking = @venue.bookings.find { |booking| booking.user == current_user }
    @review = Review.new
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end
end

# in adding a new venue, the following line will need to be input in order to use cloudinary:
# f.input :photo, as: :file
