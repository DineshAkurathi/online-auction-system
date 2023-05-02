<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.login.database.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
form {border: 3px solid #f1f1f1;}

select {
  width: 10%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

li {
  float: left;
}

li a {
  display: block;
  color: white;
  text-align: center;
  padding: 12px 14px;
  text-decoration: none;
}
li {
  display: block;
  color: white;
  text-align: center;
  padding: 12px 14px;
  text-decoration: none;
}
button {
  background-color: #333;
  color: white;
  padding: 10px 5px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 20%;
  margin-right: 10px
}

button:hover {
  opacity: 0.8;
  background-color: #04AA6D;
}
li a:hover {
  background-color:  #04AA6D;
}
td {
  border: 1px solid black;
}
</style>
<title>MyEbay</title>
<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		integrity = "sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
		crossorigin="anonymous">
		
</head>
<body>
	<% 
    	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		int userId = (Integer) session.getAttribute("userId");
		System.out.println(username);
		if (username == null) {
			System.out.println("Null username");
			response.sendRedirect("login.jsp");
		}
		Statement stmt = con.createStatement();
		String query = "SELECT * from closed_auction where username='"+username+"'";
	 	ResultSet resultset = stmt.executeQuery(query);
	 	
	 	Statement bl = con.createStatement();
	 	String bid_lim = "select ab.userId, ab.auctionId , a.itemName, a.brand,ab.b_limit  from auto_bids ab,auctions a where ab.userId="+userId+" and ab.b_limit < (select b.bidAmount from bids b where ab.auctionId=b.auctionId and ab.userId != b.buyerId order by b.bidAmount desc limit 1) and ab.auctionId = a.auctionId";
	 	ResultSet resultset1 = bl.executeQuery(bid_lim);
	 	
	 	Statement alst = con.createStatement();
		String aq = "SELECT * from product_alerts where userId='"+userId+"'";
	 	ResultSet resultset2 = alst.executeQuery(aq);
	 	ResultSet r_s1 = null;
	 	if (resultset2.next())
	 	{
	 		String itemName = resultset2.getString(2);
			System.out.println(itemName);
			String color = resultset2.getString(3);
			System.out.println(color);
			Statement s1 = con.createStatement();
			String s1_q = "SELECT * from auctions where itemName='"+itemName+"' and color='"+color+"' and status = 'OPEN'";
		 	r_s1 = s1.executeQuery(s1_q);
	 	}
	 	
	 	
	 	
    
    %>
	<ul>
  <li><a class="active" href="loginUser.jsp?">Home</a></li>
  <li><a href="createListing.jsp">Create a Listing</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
	
 <div align="center">
		<h4>Set alert for products!</h4>
 
		<form action="insertAlerts.jsp" method="post">
		  <div class="container">
			<table style="with: 100%">
				<tr>
					<td>Enter product you are interested in:</td>
					<td><input type="text" name="itemName" /></td>
				</tr>
				<tr>
					<td>Color preference</td>
					<td><input type="text" name="color" /></td>
				</tr>

			</table>
			<button type="submit" value="Submit">Set Alert</button>
			<div style="color:red">${param.message}</div>
	</div>
  
  	<br>
  	<% while(resultset1.next()){ 
          
            %>

			<table>
				<tbody>
				
						<tr>
							<td style="padding: 10px" bgcolor=red >Alert! Bid limit for <%= resultset1.getString(4) %> <%= resultset1.getString(3) %> (Auction Id: <%= resultset1.getString(2) %>)exceeded by another bidder!</td>
						</tr>
				<%	} %>
				</tbody>
			</table>
				
  	<% while(resultset.next()){ 
          
            %>

			<hr>
			<br>
			<h5 style="color: red">Alert! You have won the following auctions:</h5>
			<table class="table table-bordered">
				<thead>
					<tr>
					<th>Auction Id</th>
						<th>Username</th>
						<th>Item Name</th>
						<th>Close Amount</th>
					</tr>
				</thead>
				<tbody>
				
						<tr>
							<td bgcolor=green><%= resultset.getString(1) %></td>
							<td bgcolor=green><%= resultset.getString(6) %></td>
							<td bgcolor=green><%= resultset.getString(3) %></td>
							<td bgcolor=green><%= resultset.getString(4) %></td>
						</tr>
				
				</tbody>
			</table>
				<%	} %>
				<h5 style="color: red">Alert! The following items are now available:</h5>
	<table class="table table-bordered">
				<thead>
					<tr>
						<th>AuctionId</th>
						<th>SellerId</th>
						<th>Item</th>
						<th>Brand</th>
						<th>Category</th>
						<th>Color</th>
						<th>Size</th>
						<th>Gender</th>
						<th>Listprice</th>
						<th>Close Date</th>
						<th>Status</th>
						<th>Auction</th>
					
					</tr>
				</thead>
				<tbody>
				<% if(r_s1!=null){while(r_s1.next()){ 
          
            %>
						<tr>
							<td><%= r_s1.getString(1) %></td>
							<td><%= r_s1.getString(2) %></td>
							<td><%= r_s1.getString(3) %></td>
							<td><%= r_s1.getString(10) %></td>
							<td><%= r_s1.getString(11) %></td>
							<td><%= r_s1.getString(8) %></td>
							<td><%= r_s1.getString(7) %></td>
							<td><%= r_s1.getString(9) %></td>
							<td><%= r_s1.getString(5) %></td>
							<td><%= r_s1.getString(6) %></td>
							<td bgcolor="green"><%= r_s1.getString(12) %></td>
				<td> <a href="placeBid.jsp?auctionId=<%= r_s1.getString(1) %>">Place a bid</a></td>
						</tr>
					<%	} }%>
				</tbody>
			</table>
	
</body>
</html>