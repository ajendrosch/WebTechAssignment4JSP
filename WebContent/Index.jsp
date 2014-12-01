<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="jsp.*,java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cinema</title>
<link href="style.css" rel="stylesheet">

<script src="j/jquery.js"></script>
<script src="j/modernizr.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>

<script type="text/javascript" src="geo/geo.js"></script>

</head>
<body>

<%-- Making database connection: --%>
<%
	Connection c = MySQL.connect();
	// out.print(c);
	//MySQL.close(c);
	Statement stmnt = c.createStatement();
	String sqlStr = "SELECT seats FROM Cinema.Movies WHERE movieID =";
	sqlStr += '"' + "coherence" + '"' ;
	ResultSet coherenceSet = stmnt.executeQuery(sqlStr);
	coherenceSet.next();
	String coherenceSeats = coherenceSet.getString(1);
	
	stmnt = c.createStatement();
	sqlStr = "SELECT seats FROM Cinema.Movies WHERE movieID =";
	sqlStr += '"' + "citizenfour" + '"' ;
	ResultSet citizenfourSet = stmnt.executeQuery(sqlStr);
	citizenfourSet.next();
	String citizenfourSeats = citizenfourSet.getString(1);
	
	stmnt = c.createStatement();
	sqlStr = "SELECT seats FROM Cinema.Movies WHERE movieID =";
	sqlStr += '"' + "gigolo" + '"' ;
	ResultSet gigoloSet = stmnt.executeQuery(sqlStr);
	gigoloSet.next();
	String gigoloSeats = gigoloSet.getString(1);
	
	
%>

<%-- END OF CONNECTION ESTABLISHMENT --%>

	<header id="headerwrap">
		<div class="container">
			<div class="row">
				<h1>
					Cinema <br />Search
				</h1>
			</div>
		</div>
	</header>
	<nav class="navigation" role="navigation"></nav>

	<article>

		<section id="slide-1" class="homeSlide">
			<div class="bcg" data-center="background-position: 50% 0px;"
				data-top-bottom="background-position: 50% -100px;"
				data-anchor-target="#slide-1">

				<div class="hsContainer">
					<div class="hsContent" data-center="opacity: 1"
						data-106-top="opacity: 0" data-anchor-target="#slide-1 h2">

						<h2>1. Select a movie theater</h2>

						<section id="maps"></section>
						<div id="map-canvas"></div>
						<p>If asked, please click on allow in your browser in order to
							dermine your current geographical location and find the closest
							movie theaters to your location.</p>
						<p id="theater-block">
							Closest theatre to your location is: <strong id="closest-theater">(please
								wait)</strong>
						</p>
					</div>
				</div>
			</div>
		</section>
		<form action = "showAndSaveReservation.jsp" method = "post" id="resdata"> 
		<section id="slide-2" style="clear: left; padding-top: 20px;"
			class="homeSlide">
			<div class="bcg" data-center="background-position: 50% 0px;"
				data-top-bottom="background-position: 50% -100px;"
				data-anchor-target="#slide-2">

				<div class="hsContainer">
					<div class="hsContent" data-center="opacity: 1"
						data-106-top="opacity: 0" data-anchor-target="#slide-1 h2">
						<h2>2. Pick a movie</h2>
						Choose from one of the following available movies in this theatre:

						<ul class="movielist">
							<li>
							
								<h3><input type="radio" name="movie" value="Citizenfour" checked="checked" id="citizenfour" onclick= "displaySeats()"/><label for="citizenfour">Citizenfour</label></h3> <em>(2014) 1:54</em><br /> <img
								src="images/citizenfour.jpg" class="movieposter" /> A
								documentarian and a reporter travel to Hong Kong for the first
								of many meetings with Edward Snowden.<br /> <br /> <iframe
									width="300" height="200"
									src="//www.youtube.com/embed/XiGwAvd5mvM" frameborder="0"
									allowfullscreen></iframe>

							</li>

							<li>

								<h3><input type="radio" name="movie" value="Coherence" id="coherence" onclick= "displaySeats()"/><label for="coherence" onclick = "displaySeats()">Coherence</label></h3> <em>(2013) 1:29</em><br /> <img
								src="images/coherence.jpg" class="movieposter" /> Strange
								things begin to happen when a group of friendsgather for a
								dinner party on an evening when a comet is passing overhead<br />
								<br /> <iframe width="300" height="200"
									src="//www.youtube.com/embed/sEceDz1Rodc" frameborder="0"
									allowfullscreen></iframe>

							</li>

							<li>
								<h3><input type="radio" name="movie" value="Gigolo" id="gigolo" onclick = "displaySeats()" /><label for="gigolo">Plötzlich Gigolo</label></h3> <em>(2013) 1:30</em><br /> <img
								src="images/gigolo.jpg" class="movieposter" /> Fioravante
								decides to become a professional Don Juan as a way of making
								money to help his cash-strapped friend, Murray. With Murray
								acting as his "manager", the duo quickly finds themselves caught
								up in the crosscurrents of love and money.<br /> <br /> <iframe
									width="300" height="200"
									src="//www.youtube.com/embed/t2epX4tXfic" frameborder="0"
									allowfullscreen></iframe>

							</li>
						</ul>
						<br style="clear: left;" />
					</div>
				</div>
			</div>
		</section>

		<section id="slide-3" class="homeSlide">
			<div class="bcg" data-center="background-position: 50% 0px;"
				data-top-bottom="background-position: 50% -100px;"
				data-anchor-target="#slide-3">

				<div class="hsContainer">
					<div class="hsContent" data-center="opacity: 1"
						data-106-top="opacity: 0" data-anchor-target="#slide-1 h2">
						<h2>3. Pick your date and seats</h2>

						<p>
							Please pick a date for this movie projection: <input type="date"
								name="date" id="date" max="2014-12-31" min="2014-11-05" />
						</p>

						<p>
							Choose from the available seats for this movie projection:<br />

							<canvas id="myCanvas" width="260" height="130"
								style="border: 1px solid #000000;">
		Your browser does not support the HTML5 canvas tag.
		</canvas>
							<br /> <input id="clickMe" type="button"
								value="Show available seats" /> <br /> <span id="res"></span>

						</p>
					</div>
				</div>
			</div>
		</section>

		<section id="slide-4" class="homeSlide">
			<div class="bcg" data-center="background-position: 50% 0px;"
				data-top-bottom="background-position: 50% -100px;"
				data-anchor-target="#slide-4">

				<div class="hsContainer">
					<div class="hsContent" data-center="opacity: 1"
						data-106-top="opacity: 0" data-anchor-target="#slide-1 h2">
						<h2>4. Finish reservation</h2>
						As a last step to finish your ticket reservation, we need your
						contact data:


					<!--	<-- <form action="#" autocomplete="on" id="resdata"> -->

							<table style="border: 0;" cellpadding="2" cellspacing="0"|>
								<tr>
									<td><label for="fname">First name:</label></td>
									<td><input type="text" name="fname" id="fname" /></td>
								</tr>
								<tr>
									<td><label for="lname">Last name:</label></td>
									<td><input type="text" name="lname" id="lname" /></td>
								</tr>
								<tr>
									<td><label for="email">E-mail:</label></td>
									<td><input type="email" name="email" autocomplete="off" id="email" /></td>
								</tr>
								<tr>
									<td><label for="telephone">Cell number:</label></td>
									<td><input type="tel" name="telephone" autocomplete="on" id="telephone" /></td>
								</tr>
								<tr>
									<td></td>
								   <input type="hidden" name="seats" value ="TEST" id="hiddenseats">  
									<td><input type="submit" name="submit" id="submit"
										value="Make a reservation" /> <span id="confirmation"></span></td>
								</tr>


							</table>
						</form>
					</div>
				</div>
			</div>
		</section>
	</article>
</body>
</body>

<!--  All JavaScript from  seat.js-->
<script type="text/javascript">




window.onload = function(){
	count = 0;
	isDrawn = false;
	initial = false;
	c = document.getElementById("myCanvas");
	ctx = c.getContext("2d");
	ctx.fillStyle = "#FF0000";
	res = document.getElementById('res');
	
	c.onclick = mouse;
	document.getElementById("clickMe").onclick = displaySeats;
	//document.getElementById("resdata").onsubmit = reserveSeats;
	// document.getElementById("clearCanvas").onclick = clearCanvas;
}

function getMousePos(c, evt) {
    var rect = c.getBoundingClientRect();
    return {
		x: (evt.clientX-rect.left)/(rect.right-rect.left)*c.width,
		y: (evt.clientY-rect.top)/(rect.bottom-rect.top)*c.height
    };
}
	
function rgbToHex(r, g, b) {
	if (r > 255 || g > 255 || b > 255)
		throw "Invalid color component";
	return ((r << 16) | (g << 8) | b).toString(16);
}

var clickedSeats = [];
//handle mouseclick seat reservation
function mouse(evt){
	if(!initial)
		return;
	var taken = false;
	var mousePos = getMousePos(c, evt);

	//color newly reserved seat
	var rectZeroX = 0;
	var rectZeroY = 0;
	var message;

	for(var i = 0; i < 20; i++){
		if((Math.round(mousePos.x)-i) % 25 == 5)
			rectZeroX = Math.round(mousePos.x)-i;
	}
	for(var i = 0; i < 15; i++){
		if(Math.round((mousePos.y)-i) % 25 == 5) 
			rectZeroY = Math.round(mousePos.y)-i;
	}
	var clickedSeat = ((rectZeroY - 5) *10 / 25  ) + (rectZeroX- 5) / 25; 

	//check if spot is reserved
	var p = ctx.getImageData(rectZeroX, rectZeroY, 1, 1).data; 
	var hex = "#" + ("000000" + rgbToHex(p[0], p[1], p[2])).slice(-6);
	if(rectZeroX == 0 || rectZeroX > c.width || rectZeroY > c.height || rectZeroY < 5)
		return;
	if(hex == '#008000'){
		ctx.fillStyle = '#ffffff';
		ctx.fillRect(rectZeroX, rectZeroY, 20, 15);
		ctx.fillStyle = 'red';
		count--;
		
		var tseats = [];
		for (var i=0; i < clickedSeats.length; i++)
		{
			if (clickedSeats[i] != clickedSeat)
			{
				tseats.push(clickedSeats[i]);
			}
		}
		clickedSeats = tseats;
		if(count == 1)
			message = "You have reserved 1 seat: " + clickedSeats.toString();
		else
			message = "You have reserved "+count+" seats: " + clickedSeats.toString();
		
		document.getElementById('hiddenseats').value = clickedSeats.toString();
		document.getElementById('res').innerHTML = message;
		

		return;
	}
	if(hex == '#ff0000')
		taken = true;
	else
		taken = false;
		
	if(taken ==true){
		alert('The seat you have selected is already taken! Please choose another seat for reservation!');
		return;
	}

	count++;
	clickedSeats.push(clickedSeat);
	if(count == 1)
		message = "You have reserved 1 seat: " + clickedSeats.toString();
	else
		message = "You have reserved "+count+" seats: " + clickedSeats.toString();
	
	ctx.fillStyle = 'green';
	ctx.fillRect(rectZeroX, rectZeroY, 20, 15);
	ctx.fillStyle = 'red';
	document.getElementById('hiddenseats').value = clickedSeats.toString();
	document.getElementById('res').innerHTML = message;
}

//clear canvas 
function clearCanvas(){
	clickedSeats = [];
	ctx.clearRect(0,0,260, 130);
	isDrawn = false;
	initial = false;
	count = 0;
	document.getElementById('res').innerHTML = '';
}

//display randomly reserved seats
function displaySeats(){
	clickedSeats= [];
	//clear canvas if something has been drawn already
	initial = true;
	//if(isDrawn){
		clearCanvas();
	//}
	initial = true;
	var randomnumber = [];
	var randomnumber2 = [];
	

	
	//create random amount of taken seats
	var repeat = Math.floor(Math.random()*50);

	for(var i = 0; i < repeat; i++){ 
		randomnumber.push(Math.floor(Math.random()*10));
		randomnumber2.push(Math.floor(Math.random()*5));
	}
	// getting the current movie:
	var selectedMovie =  document.querySelector('input[name="movie"]:checked').value;
	var seats;
	switch(selectedMovie){
	case "Coherence":
		seats = "<%=coherenceSeats%>";
		break;
	case "Citizenfour":
		seats = "<%=citizenfourSeats%>";
		break;
	case "Gigolo":
		seats = "<%=gigoloSeats%>";
		break;
	}
	


		
	//draw seating plan (50 rectangles)
	for(var j = 0; j < 5; j++){
		for(var i = 0; i < 10; i++){
			ctx.strokeRect(5+25*i,5+25*j,20,15);
			if(seats.charAt(j*10+i) != 0) ctx.fillRect(5+25*i, 5+j*25, 20, 15);
			
		}
	}
}
		

function reserveSeats() {
	var resString = localStorage.getItem("reservations");
	if (resString == null || resString == "")
	{
		localStorage.setItem("reservations", []);
		resString = "[]";
	}	
	reservations = JSON.parse(resString);
	
	
	var resObj = {
			"movie": document.querySelector('input[name="movie"]:checked').value,
			"fname": document.getElementById("fname").value,
			"lname": document.getElementById("lname").value,
			"email": document.getElementById("lname").value,
			"telephone": document.getElementById("telephone").value,
			"date": document.getElementById("date").value,
			"seats": clickedSeats,
			"cinema": document.getElementById("closest-theater").innerHTML
	};
	
	reservations.push(resObj);
	
	localStorage.setItem("reservations", JSON.stringify(reservations));
	document.getElementById("confirmation").innerHTML = "Stored in local storage (localStorage.reservations).";
	return false;
}





</script>
</html>