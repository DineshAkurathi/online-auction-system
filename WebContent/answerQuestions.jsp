<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.login.database.*" %>

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
  width: 100%;
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
<% 
    	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		int userId = (Integer)session.getAttribute("userId");
		System.out.println(username);
		if (username == null) {
			System.out.println("Null username");
			response.sendRedirect("login.jsp");
		}
		Statement stmt = con.createStatement();
		String key = request.getParameter("keyword");
		String query = "select * from q_a where flag=0;";
		
			
			
	 	ResultSet resultset = stmt.executeQuery(query);
			
    %>
  <ul>
  <li><a class="active" href="loginSupport.jsp?">Home</a></li>
  <li><a href="deleteBids.jsp">Delete Bids</a></li>
  <li><a href="deleteAuctions.jsp">Delete Auctions</a></li>
 
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
	<div align="center">
		<h1>Answer Queries</h1>
 
		<table class="table table-bordered">
				<thead>
					<tr>
						<th>UserId</th>
						<th>Question</th>
						<th>Answer</th>
						<th>Submit</th>
					<!-- 	<th>Status</th>
						<th>Actions</th> -->
					</tr>
				</thead>
				<tbody>
				<% while(resultset.next()){ 
          
            %>
						<tr>
							<td><%= resultset.getString(1) %></td>
							<td><%= resultset.getString(2) %></td>
							<form action="insertAnswer.jsp?question=<%=resultset.getString(2)%>&userId=<%=resultset.getString(1)%>" method="post">
							<td><input type="text" class="form-control" name="answer" required="required"></td>
							<td><button type="submit" class="btn btn-success">Submit</button></td>
							</form>
						</tr>
					<%	} %>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>