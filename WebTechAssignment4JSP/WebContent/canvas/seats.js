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
	document.getElementById("resdata").onsubmit = reserveSeats;
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
	if(isDrawn){
		clearCanvas();
	}
	initial = true;
	var randomnumber = [];
	var randomnumber2 = [];
	
	//create random amount of taken seats
	var repeat = Math.floor(Math.random()*50);

	for(var i = 0; i < repeat; i++){ 
		randomnumber.push(Math.floor(Math.random()*10));
		randomnumber2.push(Math.floor(Math.random()*5));
	}

	//draw seating plan (50 rectangles)
	for(var j = 0; j < 5; j++){
		for(var i = 0; i < 10; i++){
			ctx.strokeRect(5+25*i,5+25*j,20,15);
		}
	}
		
	//draw reserved seats as red rectangles
	for(var i = 0; i < randomnumber.length; i++){
		ctx.fillRect(5+25*randomnumber[i], 5+randomnumber2[i]*25, 20, 15);
	}
	isDrawn = true;
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

