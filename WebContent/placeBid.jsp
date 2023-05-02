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
div {
  width: 1000px;
  border: 2px solid grey;
  padding: 50px;
  margin: 20px;
}
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
  width: 15%;
  margin-left: 10px
  margin-right: 10px
}

button:hover {
  opacity: 0.8;
  background-color: #04AA6D;
}
li a:hover {
  background-color:  #04AA6D;
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
		int itemId = Integer.parseInt(request.getParameter("auctionId"));
		System.out.println("Item Id:"+itemId);
		String username = (String) session.getAttribute("username");
		System.out.println(username);
		if (username == null) {
			System.out.println("Null username");
			response.sendRedirect("login.jsp");
		}
		Statement stmt = con.createStatement();
        ResultSet resultset = stmt.executeQuery("SELECT * from auctions WHERE auctionId="+itemId+";") ;
        resultset.next();
        Statement stmt2 = con.createStatement();
        ResultSet resultset2 = stmt2.executeQuery("SELECT u.username,b.buyerId, b.bidAmount, b.placedAt from bids b,user u WHERE b.auctionId="+itemId+" and b.buyerId = u.userId;") ;
		
        Statement stmt3 = con.createStatement();
        String query = "SELECT * from auctions WHERE itemName='"+resultset.getString(3)+"' and color='"+resultset.getString(8)+"' and auctionId!="+itemId+";";
        System.out.println(query);
        ResultSet resultset3 = stmt3.executeQuery(query);
    %>
	<ul>
  <li><a class="active" href="loginUser.jsp?">Home</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
<div>
<h5><b><u>Item Details:</u></h5><br>
<h6><b>Name: </b><%=resultset.getString(3) %></h6>
<h6><b>Price: </b><%=resultset.getString(5) %></h6>
<h6><b>Category: </b><%=resultset.getString(11) %></b></h6>
<h6><b>Close date: </b><%=resultset.getString(6) %></h6>
<form action="insertBid.jsp" method="post">
		
			<table style="with: 30%">
				<tr>
				<h5><u>Set manual bid for this listing</u></h5>
				</tr>
				<tr>
					<td><input type="hidden" name="auctionId" value="<%=itemId%>" /></td>
	   			</tr>
	   			<tr>
					<td><input type="hidden" name="price" value="<%=resultset.getString(5)%>" /></td>
	   			</tr>
					<td>Bid Amount:</td>
					<td><input type="number" name="bid" /></td>
				</tr>
			</table>
			<button type="submit" value="Submit Bid">Submit Bid</button>
			<h5 style="color:red">${param.message}<h5>
		</form>
<form action="insertAutoBid.jsp" method="post">
		
			<table style="with: 30%">
			<tr>
			<h5><u>Set automatic bid for this listing </u></h5>
			</tr>
			<tr>
					<td><input type="hidden" name="auctionId" value="<%=itemId%>" /></td>
	   			</tr>
				<tr>
				
					<td>Bid Limit:</td>
					<td><input type="number" name="bid_limit" /></td>
				</tr>
				<tr>
				
					<td>Increment:</td>
					<td><input type="number" name="increment" /></td>
				</tr>
			</table>
			<button type="submit" value="Submit Bid">Set Auto Bid</button>
			<h5 style="color:red">${param.auto_message}<h5>
		</form>
</div>
	<h3 class="text-center">Bid History</h3>
			<hr>
			<br>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Price</th>
						<th>Bidder</th>
						<th>Bid date</th>
					
					<!-- 	<th>Status</th>
						<th>Actions</th> -->
					</tr>
				</thead>
				<tbody>
				<% while(resultset2.next()){ 
          
            %>
						<tr>
							<td><%= resultset2.getString(3) %></td>
							<td><%= resultset2.getString(1) %></td>
							<td><%= resultset2.getString(4) %></td>
						</tr>
							
     
					<%	} %>
				</tbody>
			</table> 
			<h3 class="text-center">Similar Items</h3>
	<table class="table table-bordered">
				<thead>
					<tr>
						
						<th>Item</th>
						<th>Brand</th>
						<th>Category</th>
						<th>Color</th>
						<th>Size</th>
						<th>Gender</th>
						<th>Listprice</th>
						<th>Close Date</th>
					
						<th>Auction</th>
					
					<!-- 	<th>Status</th>
						<th>Actions</th> -->
					</tr>
				</thead>
				<tbody>
				<% while(resultset3.next()){ 
          
            %>
						<tr>
							<td><%= resultset3.getString(3) %></td>
							<td><%= resultset3.getString(10) %></td>
							<td><%= resultset3.getString(11) %></td>
							<td><%= resultset3.getString(8) %></td>
							<td><%= resultset3.getString(7) %></td>
							<td><%= resultset3.getString(9) %></td>
							<td><%= resultset3.getString(5) %></td>
							<td><%= resultset3.getString(6) %></td>
				<td> <a href="placeBid.jsp?auctionId=<%= resultset3.getString(1) %>">Place a bid</a></td>
						</tr>
					<%	} %>
				</tbody>
			</table>
		</div>
	
	</div>
	
</body>
</html>