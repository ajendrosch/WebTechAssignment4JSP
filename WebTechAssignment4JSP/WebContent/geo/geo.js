var map;
var infowindow;
var pos;
var latlon;

function initialize() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {

			latlon = new google.maps.LatLng(position.coords.latitude,
					position.coords.longitude);
			map = new google.maps.Map(document.getElementById('map-canvas'), {
				center : latlon,
				zoom : 13
			});
			var request = {
				location : latlon,
				radius : 4000,
				types : [ 'movie_theater' ]
			};
			infowindow = new google.maps.InfoWindow();
			var service = new google.maps.places.PlacesService(map);
			service.nearbySearch(request, callback);
		});

	}

}
function getLocationCallbackForSettingPosVariable(position) {
	pos = position;
	latlon = position.coords.latitude + "," + position.coords.longitude;
}
function callback(results, status) {
	if (status == google.maps.places.PlacesServiceStatus.OK) {
		for (var i = 0; i < results.length; i++) {
			if (i==0)				
			{
				var name = "Theatre name";
				var name = results[0].name;
				document.getElementById('closest-theater').innerHTML = name;				
			}
			createMarker(results[i]);
		}
	}
}

function createMarker(place) {
	var placeLoc = place.geometry.location;
	var marker = new google.maps.Marker({
		map : map,
		position : place.geometry.location
	})
	google.maps.event.addListener(marker, 'click', function() {
		infowindow.setContent(place.name);
		infowindow.open(map, this);
	})
}

google.maps.event.addDomListener(window, 'load', initialize);
