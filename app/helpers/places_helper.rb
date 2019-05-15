module PlacesHelper
  def build_marker(status, parking)
    Gmaps4rails.build_markers(parking) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      if status
        marker.infowindow render_to_string(partial: "/places/info_place",
          locals: {place: place, name: place.name, address: place.address,
          avail_position: place.avail_position, price: place.price})
      else
        marker.picture({
          "url" => "/my_position.png",
          "width" => Settings.width_height_marker,
          "height" => Settings.width_height_marker
        })
        marker.infowindow t("places.my_ps")
      end
    end
  end
end
