class VenuesController < ApplicationController
  before_action :set_venue, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:start].present? && params[:end].present?
      @venues = []
      compare_dates((params[:start].to_date..params[:end].to_date).to_a)
      @venues
    else
      @venues = Venue.all
    end
    set_markers
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    @venue.user = current_user
    if @venue.save!
      redirect_to venue_path(@venue), notice: "A new venue was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @review = Review.new
    # find what array it wants back
    @marker = []
    # The `geocoded` scope filters only flats with coordinates
    set_markers
    @marker << @markers.find {|m| m[:lat] == @venue.latitude && m[:lng] == @venue.longitude}
  end

  def edit; end

  def update
    if @venue.update(venue_params)
      redirect_to venue_path(@venue)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # will redirect to user page once user page is done.
  def destroy
    @venue.destroy
    redirect_to root_path, notice: 'Venue deleted'

  end

  private

  def set_markers
    @venues = Venue.all
    @markers = @venues.geocoded.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        info_window_html: render_to_string(partial: "popup", locals: {venue: venue}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :price_per_day, :location, :size_of_band, :description, :phone_number, :photo)
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
