class VenuesController < ApplicationController
  before_action :set_venue, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if (params[:start].present? && params[:end].present?) || (params[:minprice].present? || params[:maxprice].present?) || (params[:minmember].present? || params[:maxmember].present?)
      @venues = []
      compare_dates((params[:start].to_date..params[:end].to_date).to_a, (params[:minprice].to_i..params[:maxprice].to_i).to_a, (params[:minmembers].to_i..params[:maxmembers].to_i).to_a)
      # compare_dates((params[:minprice].to_i..params[:maxprice].to_i).to_a)
      # compare_dates((params[:minmembers].to_i..params[:maxmembers].to_i).to_a)
      @venues
      # raise
    else
      @venues = Venue.all
    end
    set_markers
    # session[:search_start] = params[:start]
    # session[:search_end] = params[:end]
  end

# @ venues.select do |venue|
#   find the venue that fills the criterea for the price, band size (min max) and dates
#   no duplicates that would come in (subtract arrays?)
# end


  def show
    @review = Review.new
    @marker = []
    set_markers
    @marker << @markers.find { |m| m[:lat] == @venue.latitude && m[:lng] == @venue.longitude }
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

  def edit; end

  def update
    if @venue.update(venue_params)
      redirect_to venue_path(@venue)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @venue.destroy
    redirect_to profile_path, notice: 'Venue deleted'
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

  def compare_dates(range_date, range_price, range_member)
    Venue.all.each do |venue|
      available = true
      venue.bookings.each do |booking|
        available = false if ((booking.start_date..booking.end_date).to_a & range_date).any?
      end
      @venues << venue if available
    end
    price = @venues.select do |venue|
      range_price.include?(venue.price_per_day)
    end
    members = price.select do |venue|
      range_member.include?(venue.size_of_band)
    end
    @venues = members
  end
end

# @ venues.select do |venue|
#   find the venue that fills the criterea for the price, band size (min max) and dates
#   no duplicates that would come in (subtract arrays?)
# end

# create smaller or refactored private methods
# test just one price, for example
