class PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def create
    @place = Place.find_place(params[:place][:latitude], params[:place][:longitude]).first
    if @place.nil?
      @place = Place.create(place_params)
      if @place.save
        redirect_to @place
      else
        flash[:danger] = t("places.not_create_place")
        redirect_to root_url
      end
    else
      redirect_to @place
    end
  end

  def show
    @place = Place.find_by(id: params[:id])
    if @place.nil?
      flash[:danger] = t("places.not_find_place")
    else
      @parkings = Parking.near([@place.latitude, @place.longitude],
        Settings.distance_find_park, units: :km)
      @hash = build_marker(true, @parkings)
      @my_position = build_marker(false, @place)
    end
  end

  private

  def place_params
    params.require(:place).permit :latitude, :longitude
  end
end
