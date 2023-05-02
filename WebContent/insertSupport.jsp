<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.login.database.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String lookup = "Insert into user(username,password,role) values (?,?,?)";
			PreparedStatement ps = con.prepareStatement(lookup);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3,"S");
			int result = ps.executeUpdate();
			if (result > 0) {
		
				%>
				<jsp:forward page="loginAdmin.jsp">
				<jsp:param name="message" value="Create Account Successfull!"/> 
				</jsp:forward>
				<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			} else {
				%>
				<jsp:forward page="loginAdmin.jsp">
				<jsp:param name="message" value="Please enter again!"/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			%>
				<jsp:forward page="loginAdmin.jsp">
				<jsp:param name="message" value="Please enter again!"/> 
				</jsp:forward>
				<%
		}
	%>
</body>
</html>
