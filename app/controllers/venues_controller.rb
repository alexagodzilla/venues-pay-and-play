class VenuesController < ApplicationController
  before_action :set_venue, only: [:show]
  def index
    @venues = Venue.all
  end

  def show
    @booking = Booking.new
    @review = Review.new
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end
end

# in adding a new venue, the following line will need to be input in order to use cloudinary:
# f.input :photo, as: :file
