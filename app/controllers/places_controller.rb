class PlacesController < ApplicationController
  def new
    @place = Place.new
  end

  def create
    @place = Place.where(longitude: params[:place][:longitude],
      latitude: params[:place][:latitude]).first
    if @place.nil?
      @place = Place.create(place_params)
      @place.save
      redirect_to @place
    else
      redirect_to @place
    end
  end

  def show
    @place = Place.find_by(id: params[:id])
    @parkings = Parking.near([@place.latitude, @place.longitude], 10, units: :km)
    @hash = Gmaps4rails.build_markers(@parkings) do |parking, marker|
      marker.lat parking.latitude
      marker.lng parking.longitude
      marker.infowindow render_to_string(:partial => "/places/info_place",
        :locals => {:parking => parking, :name => parking.name, :address => parking.address,
          :avail_position => parking.avail_position, :price => parking.price})
    end
    @my_position = Gmaps4rails.build_markers(@place) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.picture({
        "url" => "/my_position.png",
        "width" => 40,
        "height" => 40
      })
      marker.infowindow "Vị trí của tôi"
    end
  end

  private

  def place_params
    params.require(:place).permit(:latitude, :longitude)
  end
end
