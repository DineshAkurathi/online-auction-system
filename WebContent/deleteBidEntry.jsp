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
			
			int bidId = Integer.parseInt(request.getParameter("bidId"));
			System.out.println("Deleting");
			String delete = "Delete from bids where bidId = (?)";
			PreparedStatement ds = con.prepareStatement(delete);
			ds.setInt(1, bidId);
			int res = ds.executeUpdate();
				%>
				<jsp:forward page="deleteBids.jsp"> 
				<jsp:param name="message" value="Success"/> 
				</jsp:forward>
				<%
		
			
		} catch (Exception e) {
			%>
				<jsp:forward page="deleteBids.jsp"> 
				<jsp:param name="message" value="Fail"/> 
				</jsp:forward>
				<%
		}
	%>
</body>
</html>
