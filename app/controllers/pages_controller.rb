class PagesController < ApplicationController
  def profile
    @bookings = current_user.bookings
    @venues = current_user.venues
  end
end
