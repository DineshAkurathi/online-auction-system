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
  width: 50%;
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
		
		String query = "select question,answer from q_a where flag = 1";
		String key = request.getParameter("keyword");
		if (key!=null){
			query =  query + " and question like '%"+key+"%';";
		}else{
			query = query+";";
		}
		System.out.println(query);
		ResultSet resultset = stmt.executeQuery(query);
			
    %>
	<ul>
  <li><a class="active" href="loginUser.jsp">Home</a></li>
  <li><a class="active" href="createListing.jsp">Create Listing</a></li>
  <li><a href="alerts.jsp">Alerts</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
	<div align="center">
		<h1>Contact Support</h1>
 
	<div class="container col-md-5">
		<div class="card">
				<div class="card-body">
				<form action="insertQuestion.jsp" method="post">
					<div style="color:red">${param.message}</div>
					<fieldset class="form-group">
                    	<label>Enter Query</label>
                    	<input type="text" class="form-control" name="question" >
                    </fieldset>
                    <button type="submit" class="btn btn-success">Submit Query</button>
                </form>
				</div>
		</div>
		
		<div class="card">
				<div class="card-body">
				<form action="contactSupport.jsp" method="post">
					<div style="color:red">${param.message}</div>
					<fieldset class="form-group">
                    	<label>Search: </label>
                    	<input type="text" class="form-control" name="keyword" required="required">
                    </fieldset>
                    <button type="submit" class="btn btn-success">Find</button>
                </form>
				</div>
		</div>
		
		<table class="table table-bordered">
				<thead>
					<tr>
						<th>Question</th>
						<th>Answer</th>
						<!-- <th>Status</th> -->
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
							
							<%-- <%if(resultset.getInt(3)==1){
                	%>
                	<TD bgcolor="green">Answered</TD>
                	<%
                }else{
                	%>
            		<TD bgcolor="red">Unanswered</TD>
            		<%
                } %> --%>
						</tr>
					<%	} %>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>