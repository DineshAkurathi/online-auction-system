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
/* form {border: 3px solid #f1f1f1;} */

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
  <li><a class="active" href="loginAdmin.jsp?">Home</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
	</ul>
<div class = "container" align ="center" style="display: block; align-items: center; ">
	<h3 style = "padding: 10px;">Sales Report</h3>

	<button  onclick="printFunction()" style="width:120px; margin: 10px;">Print</button>
	<script>
	      function printFunction() { 
	
	    	    /* var el = document.getElementById("filter form");
	
	    	      el.style.display = 'none'; */
	        window.print(); 
	      }
	</script>

</div>
<div class = "container">
<table class="table">

  <%
  	Statement query = con.createStatement();
  	ResultSet resultSet = query.executeQuery("select sum(close_amount) as totalEarnings from closed_auction;");
  	resultSet.next();
  %>
  <tr>
    <td style="padding: 10px;">Total Earnings:</td>
    <td style="padding: 10px;">$ <%= resultSet.getInt("totalEarnings")%> </td>
  </tr>
  <%
  	/* Statement query2 = con.createStatement(); */
  	ResultSet resultSet2 = query.executeQuery("SELECT itemName, SUM(close_amount) AS earnings FROM closed_auction GROUP BY itemName;");
  	
  %>
  <tr>
    <td style="padding: 10px;">Earnings by Items:</td>
    <td style="padding: 10px;">
    	<% 
    	while(resultSet2.next()) {
      	String itemName = resultSet2.getString("ItemName");
      	String earnings = resultSet2.getString("earnings");
  		%>
  		<%= itemName %>: $ <%= earnings %> <br>
  		<% } %>
    </td>
  </tr>
  <%
  ResultSet resultSet3 = query.executeQuery("select t.category, sum(t.close_amount) as earnings from (select ca.auctionId, ca.sellerId, ca.itemName, ca.close_amount, ca.winner, ca.username, cat.category from closed_auction as ca inner join (select auctionId, category from auctions) as cat on ca.auctionId = cat.auctionId) as t group by t.category;");
  %>
  <tr>
    <td style="padding: 10px;">Earnings by Item Type:</td>
    <td style="padding: 10px;">
    	<% 
    	while(resultSet3.next()) {
      	String category = resultSet3.getString("category");
      	String earnings = resultSet3.getString("earnings");
  		%>
  		<%= category %>: $ <%= earnings %> <br>
  		<% } %>
    </td>
  </tr>
  <%
  String query3 = "select t1.userId, t1.earnings, t2.username from (select winner as userId, sum(close_amount) as earnings from closed_auction group by winner having winner!=0) as t1 inner join (select username, winner from closed_auction) as t2 on t1.userId = t2.winner;";
  ResultSet resultSet4 = query.executeQuery(query3);
  %>
  <tr>
    <td style="padding: 10px;">Earnings by End User:</td>
    <td style="padding: 10px;">
    	<% 
    	while(resultSet4.next()) {
      	String user_name = resultSet4.getString("username");
      	String earnings = resultSet4.getString("earnings");
  		%>
  		<%= user_name %>: $ <%= earnings %> <br>
  		<% } %>
    </td>
  </tr>
  
  <%
  String query4 = "select ca.itemName, count(ca.itemName) as sales from (select * from closed_auction where winner != 0) as ca group by (ca.itemName) order by sales desc limit 2;";
  ResultSet resultSet5 = query.executeQuery(query4);
  
  %>
  <tr>
    <td style="padding: 10px;">Best Selling Items:</td>
    <td style="padding: 10px;">
    	<% 
    	while(resultSet5.next()) {
      	String item_name = resultSet5.getString("itemName");
      	String sales = resultSet5.getString("sales");
  		%>
  		<%= item_name %>: <%= sales %> <br>
  		<% } %>
    </td>
  </tr>
  <%
  String query5 = "select t2.winner as userId, t1.username, t1.purchaseCount from (select username, count(username) as purchaseCount from closed_auction group by username having username is not null order by purchaseCount limit 1) as t1 inner join (select winner, username from closed_auction) as t2 on t1.username = t2.username;";
  ResultSet resultSet6 = query.executeQuery(query5);
  %>
  <tr>
    <td style="padding: 10px;">Best Buyer by Total Purchase: </td>
    <td style="padding: 10px;">
    	<% 
    	while(resultSet6.next()) {
      	String user_name = resultSet6.getString("username");
  		%>
  		<%= user_name %>
  		<% } %>
    
    </td>
  </tr>
  <%
  String query6 = "select t1.userId, t1.earnings, t2.username from (select winner as userId, sum(close_amount) as earnings from closed_auction group by winner having winner!=0) as t1 inner join (select username, winner from closed_auction) as t2 on t1.userId = t2.winner order by earnings desc limit 1;";
  ResultSet resultSet7 = query.executeQuery(query6);
  %>
  <tr>
    <td style="padding: 10px;">Best Buyer by Expenditure:</td>
    <td style="padding: 10px;">
    	<% 
    	while(resultSet7.next()) {
      	String user_name = resultSet7.getString("username");
  		%>
  		<%= user_name %>
  		<% } %>
    
    </td>
  </tr>
</table>

</div>		
		
</body>
</html>