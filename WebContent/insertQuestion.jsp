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
		
			
			int userId = (Integer) session.getAttribute("userId");
			Statement stmt = con.createStatement();
			String question = request.getParameter("question");
			String color = request.getParameter("color");
			
			String lookup = "Insert into q_a(userId,question,answer) values (?,?,?)";
			PreparedStatement ps = con.prepareStatement(lookup);
			ps.setInt(1, userId);
			ps.setString(2, question);
			ps.setString(3,"");
			int result = ps.executeUpdate();
			if (result > 0) {
		
				%>
				<jsp:forward page="contactSupport.jsp">
				<jsp:param name="message" value="Query submitted successfully!"/> 
				</jsp:forward>
				<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			} else {
				%>
				<jsp:forward page="contactSupport.jsp">
				<jsp:param name="message" value="Failed!"/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			%>
				<jsp:forward page="alerts.jsp">
				<jsp:param name="message" value="Please enter again!"/> 
				</jsp:forward>
				<%
		}
	%>
</body>
</html>
