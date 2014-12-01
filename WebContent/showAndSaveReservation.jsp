<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="jsp.*,java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thank You!</title>
<link href="style.css" rel="stylesheet">
</head>
<body>

	<%-- Making database connection: --%>
	<%
		Connection c = MySQL.connect();
	%>
	<%-- END OF CONNECTION ESTABLISHMENT --%>

	<%
		// Inserting data except reserved seats into database and receiving LAST_INSERT_ID which is then the reservationID
		Statement stmt = c.createStatement();
		String sqlStr = "INSERT INTO  `Cinema`.`Reservations` (`firstName`, `lastName`, `eMail`, `cellNumber`, `movieID`, `date`) VALUES (";
		sqlStr += "'" + request.getParameter("fname") + "'" + ",";
		sqlStr += "'" + request.getParameter("lname") + "'" + ",";
		sqlStr += "'" + request.getParameter("email") + "'" + ",";
		sqlStr += "'" + request.getParameter("telephone") + "'" + ",";
		sqlStr += "'" + request.getParameter("movie") + "'" + ",";
		sqlStr += "'" + request.getParameter("date") + "'";
		sqlStr += ")";
		stmt.executeUpdate(sqlStr);
		sqlStr= "SELECT LAST_INSERT_ID();";
		ResultSet resSetWithLastID = stmt.executeQuery(sqlStr);
		resSetWithLastID.next();
		int reservationID = resSetWithLastID.getInt(1);
		

		// Insertion of reserved seats into database
		// this works by first requesting the current seat data from the db, overwriting with "1" for the seats that are stored in the request
		Statement gettintSeatsStmnt = c.createStatement();
		String gettingSeatsSqlStr = "SELECT seats FROM Cinema.Movies Where movieID=";
		gettingSeatsSqlStr += "'" + request.getParameter("movie") + "'";
		ResultSet seatsSet = gettintSeatsStmnt
				.executeQuery(gettingSeatsSqlStr);
		seatsSet.next();
		String oldSeatsAsString = seatsSet.getString(1);
		char[] oldSeats = oldSeatsAsString.toCharArray();
		String[] reservedSeatsAsString = request.getParameter("seats")
				.split(",");
		int numSeats = reservedSeatsAsString.length;
		int[] reservedSeats = new int[numSeats];
		for (int i = 0; i < reservedSeatsAsString.length; i++) {
			oldSeats[Integer.parseInt(reservedSeatsAsString[i])] = '1';
		}
		String newSeats = new String(oldSeats);

		Statement settingSeatsStmnt = c.createStatement();
		String settingSeatsSqlStr = "UPDATE `Cinema`.`Movies` SET `seats`='"
				+ newSeats
				+ "'"
				+ " WHERE `movieID`='"
				+ request.getParameter("movie") + "'";
		settingSeatsStmnt.executeUpdate(settingSeatsSqlStr);
		
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String email = request.getParameter("email");
		String telephone = request.getParameter("telephone");
		String movie = request.getParameter("movie");
		
	
	%>
	
	<!--  Actual displayed HTML Page: -->

	<H1>
		Thank you
		<%=fname%>
		<%=lname%>
		for your reservation.
	</H1>
	<div>
		You reserved:
		<%=numSeats%>
		x Tickets for
		<%=movie%>. Your reservation ID is <%=reservationID%>.
	</div>

</body>
</html>