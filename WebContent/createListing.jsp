<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.login.*" %>

<html>
<head>
<meta charset="UTF-8">
<title>New Auction</title>
<style>
select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}
option {
  width: 100%;
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
button {
  background-color: #333;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 20%;
}

button:hover {
  opacity: 0.8;
  background-color: #04AA6D;
}

li {
  float: left;
}

li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover {
  background-color:  #04AA6D;
}
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>

	<ul>
  <li><a class="active" href="loginUser.jsp">Home</a></li>
  <li><a href="alerts.jsp">Alerts</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
	<div align="center">
		<h1>Create a Listing</h1>
 
	<div class="container col-md-5">
		<div class="card">
				<div class="card-body">
				<form action="insertAuction.jsp" method="post">
					<div style="color:red">${param.message}</div>
					<fieldset class="form-group">
                    	<label>Item Name</label>
                    	<input type="text" class="form-control" name="itemName" required="required">
                    </fieldset>
                    <fieldset class="form-group">
                    	<label>Brand</label>
                    	<input type="text" class="form-control" name="brand" required="required">
                    </fieldset>
                    <fieldset class="form-group">
                    	<label>Category</label>
                    	<tr>  
	  			<!-- 	<label for="subcategory">Subcategory:</label> -->
	  				<select name="category" id="category" name="category">
	    				<option value="NONE">-SELECT AN OPTION-</option>
	    				<option value="Tops">Tops</option>
	    				<option value="Bottoms">Bottoms</option>
	    				<option value="Footwear">Footwear</option>
	  				</select>					
	   			</tr>
                    </fieldset>
                    <fieldset class="form-group">
                    	<label>Color</label>
                    	<input type="text"  class="form-control" name="color" required="required">
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Size</label>
                    	<input type="text"  class="form-control" name="size" required="required">
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Gender</label>
                    	<input type="text"  class="form-control" name="gender" required="required">
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>List Price</label>
                    	<input type="text"  class="form-control" name="listprice" required="required">
                    </fieldset>
                    
                    <fieldset class="form-group">
                    	<label>Reserve Price</label>
                    	<input type="text"  class="form-control" name="reserve" required="required">
                    </fieldset>
                    
					
					<fieldset class="form-group">
                    	<label>Close Date</label>
                    	<input type="datetime-local" class="form-control" name="closeDate">
					</fieldset>
                    <button type="submit" class="btn btn-success">Create Listing</button>
                </form>
				</div>
		</div>
	</div>
</body>
</html>