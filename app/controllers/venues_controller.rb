class VenuesController < ApplicationController
  before_action :set_venue, only: [:show]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:start].present? && params[:end].present?
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
      available = true
      venue.bookings.each do |booking|
        available = false if ((booking.start_date..booking.end_date).to_a & date_range).any?
      end
      @venues << venue if available
    end
  end
end
