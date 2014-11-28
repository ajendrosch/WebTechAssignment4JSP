function supports(bool, suffix) {
	var s = "Your browser ";
	if (bool) {
		s += "supports " + suffix + ".";
	} else {
		s += "does not support " + suffix + ". :(";
	}
	return s;
}

function show_map(loc) {
	$("#geo-wrapper").css({
		'width' : '320px',
		'height' : '350px'
	});
	var map = new google.maps.Map(document.getElementById("geo-wrapper"), {
		zoom : 14,
		mapTypeControl : true,
		zoomControl : true,
		mapTypeId : google.maps.MapTypeId.ROADMAP
	});
	var center = new google.maps.LatLng(loc.coords.latitude,
			loc.coords.longitude);
	map.setCenter(center);
	var marker = new google.maps.Marker({
		map : map,
		position : center,
		draggable : false,
		title : "You are here (more or less)"
	});
}
function show_map_error() {
	$("#live-geolocation").html('Unable to determine your location.');
}
(function() {
	if (geoPosition.init()) {
		$("#live-geolocation")
				.html(
						supports(true, "geolocation")
								+ ' <a href="#" onclick="lookup_location();return false">Click to look up your location</a>.');
	} else {
		$("#live-geolocation").html(supports(false, "geolocation"));
	}
});

geoPosition.getCurrentPosition(show_map, show_map_error);