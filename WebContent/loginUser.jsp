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
  <li><a class="active" href="loginUser.jsp?">Home</a></li>
  <li><a href="createListing.jsp">Create a Listing</a></li>
  <li><a href="contactSupport.jsp">Contact Support</a></li>
  <li><a href="alerts.jsp">Alerts</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
	<h3 style = "padding-left:50px;">Auctions</h3>
	
		<div class="container" style="display:flex;height: 200px; width:600px;">
			
			
	
			<form method="post" action="loginUser.jsp">
				<label for="gender">Gender: </label>
				<input type="radio" name="gender" value="M" /> Male 
				<input type="radio" name="gender" value="F"/> Female
				<br>
				
				<label for="size">Size: </label>
				<input type="radio" name="size" value="S" />S
				<input type="radio" name="size" value="M" /> M
				<input type="radio" name="size" value="L" /> L		
				<br />
				
				<label for="category">Category: </label>
				<input type="radio" name="category" value="Tops" />Tops
				<input type="radio" name="category" value="Bottoms" /> Bottoms
				<input type="radio" name="category" value="Footwear" /> Footwear		
				<br />
				
				<label for="sellerId">Seller Id: </label>
				<input type="text" name="sellerId" id="seller" />

				
				<label for="buyerId">Buyer Id: </label>
				<input type="text" name="buyerId" id="buyer" />
				<br />
				
				<label for="sort"> Sort by: </label>
				<select name="sortby" id="sortby" style=" min-width: 250px;">
					<option value="ltoh">---</option>
			    	<option value="htol">Price: Highest to Lowest</option>
			    	<option value="ltoh">Price: Lowest to Highest</option>
				</select>
				<br/>
				
		    	<button type="submit" name="filterby" value = "filterBy" style="width:220px;">Filter and Sort</button>
		    		

		  	</form>
  
  			<br/>
<% 
			Statement stmt = con.createStatement();
  			String query = "select distinct a.auctionId, a.sellerID, a.itemName, a.brand, a.category, a.color, a.size, a.gender, a.listprice, a.closeDate, a.status "+
						"from auctions as a "+
  					"left join " +
  					"(select auctionId, buyerId from bids) as t "+
  					"on a.auctionId = t.auctionId ";
  			
  			String gender = request.getParameter("gender");
  			String size = request.getParameter("size");
  			String category = request.getParameter("category");
  			String sellerId = request.getParameter("sellerId");
  			String buyerId = request.getParameter("buyerId");
  			String sortby = request.getParameter("sortby");
  			
  			/* System.out.println("GENDER: "+ gender);
  			System.out.println("SIZE: "+ size);
  			System.out.println("CATEGORY: "+ category);
  			System.out.println("SELLERID: "+sellerId);
  			
  			System.out.println("BUYERID: "+buyerId);
  			System.out.println("SORTBY: "+sortby); */
  			
  			if (gender!=null || size!=null || category!= null || (sellerId != null && !sellerId.equals("")) || (buyerId != null && !buyerId.equals(""))){
  				query = query + " where ";
  			}
    	 	
			if(gender != null){
				query = query + " gender='"+gender+"' ";	
			}
			
			if(size != null){
				if(gender != null){
					query = query + "and ";
				}
				query = query + "size='"+size+"' ";
			}
		
			if(category != null){
				if (gender != null || size!=null){
					query = query +"and ";	
				}
				query = query + "category='"+category+"' ";
			}
			
			if(sellerId != null && sellerId != ""){
				if (gender != null || size!=null || category != null){
					query = query +"and ";	
				}
				query = query + "sellerId="+sellerId+" ";
			}
			
			if(buyerId != null && buyerId != ""){
				if (gender != null || size!=null || category != null || (sellerId !=null && sellerId != "") ){
					query = query +"and ";	
				}
				query = query + "t.buyerId="+buyerId+" ";
			}
			
			if (sortby != null && sortby.equals("htol")){
				System.out.println("htol");
				query = query + "order by listprice DESC";
			}
			else{
				System.out.println("");
				query = query + "order by listprice";
			}
			
				
			
			System.out.println("QUERY: "+ query);

			ResultSet resultset = stmt.executeQuery(query+";");
    	 	

    	 	
%>
	</div>


			<br/>
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
				<% while(resultset.next()){ %>
						<tr>
							<td><%=resultset.getString("auctionId") %></td>
							<td><%= resultset.getString("sellerId") %></td>
							<td><%= resultset.getString("itemName") %></td>
							<td><%= resultset.getString("brand") %></td>
							<td><%= resultset.getString("category") %></td>
							<td><%= resultset.getString("color") %></td>
							<td><%= resultset.getString("size") %></td>
							<td><%= resultset.getString("gender") %></td>
							<td><%= resultset.getString("listprice") %></td>
							<td><%= resultset.getString("closeDate") %></td>
							<%if(resultset.getString("status").equals("OPEN")){%>
                				<td bgcolor="green">Open</td>
                			<%}else{ %>
            					<td bgcolor="red">Closed</td>
            				<%} %>
                
							<td> <a href="placeBid.jsp?auctionId=<%= resultset.getString("auctionId") %>">Place a bid</a></td>
						</tr>
				<%	} %>
				</tbody>
			</table>

		
</body>
</html>