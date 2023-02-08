class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def show
  end
end

# in adding a new venue, the following line will need to be input in order to use cloudinary:
# f.input :photo, as: :file
