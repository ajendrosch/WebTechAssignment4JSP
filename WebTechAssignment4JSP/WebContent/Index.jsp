<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cinema</title>
<link href="style.css" rel="stylesheet">
<script type="text/javascript" src="canvas/seats.js"></script>
<script src="j/jquery.js"></script>
<script src="j/modernizr.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>

<script type="text/javascript" src="geo/geo.js"></script>

</head>
<body>
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
								<h3><input type="radio" name="movie" value="Citizenfour" checked="checked" id="citizenfour"/><label for="citizenfour">Citizenfour</label></h3> <em>(2014) 1:54</em><br /> <img
								src="images/citizenfour.jpg" class="movieposter" /> A
								documentarian and a reporter travel to Hong Kong for the first
								of many meetings with Edward Snowden.<br /> <br /> <iframe
									width="300" height="200"
									src="//www.youtube.com/embed/XiGwAvd5mvM" frameborder="0"
									allowfullscreen></iframe>

							</li>

							<li>

								<h3><input type="radio" name="movie" value="Coherence" id="coherence" /><label for="coherence">Coherence</label></h3> <em>(2013) 1:29</em><br /> <img
								src="images/coherence.jpg" class="movieposter" /> Strange
								things begin to happen when a group of friendsgather for a
								dinner party on an evening when a comet is passing overhead<br />
								<br /> <iframe width="300" height="200"
									src="//www.youtube.com/embed/sEceDz1Rodc" frameborder="0"
									allowfullscreen></iframe>

							</li>

							<li>
								<h3><input type="radio" name="movie" value="Gigolo" id="gigolo" /><label for="gigolo">Plötzlich Gigolo</label></h3> <em>(2013) 1:30</em><br /> <img
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
								value="Show Random Seats" /> <br /> <span id="res"></span>

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


						<form action="#" autocomplete="on" id="resdata">

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
</html>