class PagesController < ApplicationController
  def profile
    @bookings = current_user.bookings
    @venues = current_user.venues
    @future_bookings = current_user.bookings.select { |booking| booking.end_date >= Date.today }
    @past_bookings = current_user.bookings.select { |booking| booking.end_date < Date.today }
  end
end
