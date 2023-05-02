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
			int userId = Integer.parseInt(request.getParameter("id"));
			String action = request.getParameter("action");
			System.out.println(action);
			String lookup = "select role from user where userId = (?)";
			PreparedStatement ps = con.prepareStatement(lookup);
			ps.setInt(1, userId);
			ResultSet result = ps.executeQuery();
			if (result.next()) {
				String role = result.getString(1);
				if(role.equals("A")){
					%>
					<jsp:forward page="loginSupport.jsp">
					<jsp:param name="message" value="Cannot Edit Account Details for Admin."/> 
					</jsp:forward>
					<%
				}
			}
			else{
				%>
				<jsp:forward page="loginSupport.jsp">
				<jsp:param name="message" value="Account does not exist. Please enter details again."/> 
				</jsp:forward>
				<%
			}
			if(action.equals("delete")){
				
				System.out.println("Deleting");
				
				String delete = "Delete from user where userId = (?)";
				PreparedStatement ds = con.prepareStatement(delete);
				ds.setInt(1, userId);
				int res = ds.executeUpdate();
				if (res>0) {
					%>
					<jsp:forward page="loginSupport.jsp">
					<jsp:param name="message" value="Deleted Successfully!"/> 
					</jsp:forward>
					<%
			
				} else {
					%>
					<jsp:forward page="loginSupport.jsp">
					<jsp:param name="message" value="Delete Failed"/> 
					</jsp:forward>
					<%
				}
				
				
				
			}
			else{
				System.out.println("Updating");
				String update = "Update user set username = (?) where userId = (?);";
				PreparedStatement us = con.prepareStatement(update);
				us.setString(1, username);
				us.setInt(2, userId);
				System.out.println(us);
				int res = us.executeUpdate();
				if (res>0) {
					%>
					<jsp:forward page="loginSupport.jsp">
					<jsp:param name="message" value="Update Success!"/> 
					</jsp:forward>
					<%
			
				} else {
					%>
					<jsp:forward page="loginSupport.jsp">
					<jsp:param name="message" value="Update Failed"/> 
					</jsp:forward>
					<%
				}
			}
			
		} catch (Exception e) {
			%>
			<jsp:forward page="loginSupport.jsp">
			<jsp:param name="message" value="Error.Please try again."/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>
