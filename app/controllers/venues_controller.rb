class VenuesController < ApplicationController
  before_action :set_venue, only: [:show]

  def index
    if params[:start].present? || params[:end].present?
      @venues = []
      compare_dates((params[:start].to_date..params[:end].to_date).to_a)
      @venues
    else
      @venues = Venue.all
    end
  end

  def show
    # @booking = @venue.bookings.find { |booking| booking.user == current_user }
    @venue = Venue.find(params[:id])
    @review = Review.new
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def compare_dates(date_range)
    Venue.all.each do |venue|
      venue.bookings.each do |booking|
        @venues << venue unless ([booking.start_date, booking.end_date] & date_range).any?
      end
    end
  end
end

# in adding a new venue, the following line will need to be input in order to use cloudinary:
# f.input :photo, as: :file
