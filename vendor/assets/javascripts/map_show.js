$(document).ready(function() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    console.log(I18n.t('not_support_geolocation'));
  }


  function showPosition(position) {
    var my_lat = position.coords.latitude;
    var my_lng = position.coords.longitude;
    var lati = $('#latitude').text();
    var longi = $('#longitude').text();
    var name_park = $('#park_name').text();
    handler = Gmaps.build(I18n.t('google'));
    handler.buildMap({ provider: {}, internal: {id: 'map_show'}}, function(){
      markers = handler.addMarkers([
      {
        'lat': lati,
        'lng': longi,
        'picture': {
          'width':  32,
          'height': 32
        },
        'infowindow': name_park
      }
      ]);
      my_position_marker = handler.addMarkers([
      {
        'lat': my_lat,
        'lng': my_lng,
        'picture': {
          'url': '/my_position.png',
          'width':  32,
          'height': 32
        },
        'infowindow': I18n.t('places.my_ps')
      }
      ]);
      handler.bounds.extendWith(markers);
      handler.bounds.extendWith(my_position_marker);
      handler.fitMapToBounds();
    });
    var map = handler.getMap();
    var directionsDisplay = new google.maps.DirectionsRenderer();
    var directionsService = new google.maps.DirectionsService();
    var service = new google.maps.DistanceMatrixService();
    var start_position = new google.maps.LatLng(my_lat, my_lng);
    var end_position = new google.maps.LatLng(lati, longi);
    var infoWindow = new google.maps.InfoWindow();
    directionsDisplay.setMap(map);
    var middle;
    directionsDisplay.setOptions({suppressMarkers: true});

    var request = {
      origin: start_position,
      destination: end_position,
      travelMode: 'DRIVING'
    };
    directionsService.route(request, function(response, status) {
      if(status == 'OK') {
        directionsDisplay.setDirections(response);
        var m = Math.ceil((response.routes[0].overview_path.length)/2);
        middle = response.routes[0].overview_path[m];
        service.getDistanceMatrix(
        {
          origins: [start_position],
          destinations: [end_position],
          travelMode: 'DRIVING',
        }, function(response, status){
          if(status == 'OK') {
            var origins = response.originAddresses;
            var destinations = response.destinationAddresses;

            for (var i = 0; i < origins.length; i++) {
              var results = response.rows[i].elements;
              for (var j = 0; j < results.length; j++) {
                var element = results[j];
                var distance = element.distance.text;
                var duration = element.duration.text;
              }
            };
            var content = '<div>' + distance + '<br>' + duration + '</div>';
            infoWindow.setContent(content);
            infoWindow.setPosition(middle);
            infoWindow.open(map);
          }
        });
      } else {
        window.alert(I18n.t('error_find_road') + status);
      }
    })
  }
})
