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
		System.out.println(username);
		if (username == null) {
			System.out.println("Null username");
			response.sendRedirect("login.jsp");
		}
			
    %>
	<ul>
  <li><a class="active" href="loginSupport.jsp?">Home</a></li>
  <li><a href="deleteBids.jsp">Delete Bids</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
	<div class="row">
		<div class="container">
			<h3 class="text-center">Delete Auctions</h3>
			<div class="container">

  	<br>
  <% 
			Statement stmt = con.createStatement();
    	 	String sortParam = request.getParameter("filterby");
    	 	ResultSet resultset = stmt.executeQuery("SELECT * from auctions;");

       	 %>
</div>
			<hr>
			<br>
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
						<th>Delete</th>
					
					</tr>
				</thead>
				<tbody>
				<% while(resultset.next()){ 
          
            %>
						<tr>
							<td><%= resultset.getString(1) %></td>
							<td><%= resultset.getString(2) %></td>
							<td><%= resultset.getString(3) %></td>
							<td><%= resultset.getString(10) %></td>
							<td><%= resultset.getString(11) %></td>
							<td><%= resultset.getString(8) %></td>
							<td><%= resultset.getString(7) %></td>
							<td><%= resultset.getString(9) %></td>
							<td><%= resultset.getString(5) %></td>
							<td><%= resultset.getString(6) %></td>
							<%if(resultset.getString(12).equals("OPEN")){
                	%>
                	<TD bgcolor="green">Open</TD>
                	<%
                }else{
                	%>
            		<TD bgcolor="red">Closed</TD>
            		<%
                } %>
				<td> <a href="deleteAuctionEntry.jsp?auctionId=<%= resultset.getString(1) %>">Delete</a></td>
						</tr>
					<%	} %>
				</tbody>
			</table>
		</div>
	
	</div>
	
</body>
</html>