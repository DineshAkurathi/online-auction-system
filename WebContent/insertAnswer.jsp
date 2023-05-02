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
			System.out.println("Hello");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			int userId = Integer.parseInt(request.getParameter("userId"));
			System.out.println(userId);
			String question = request.getParameter("question");
			System.out.println(question);
			String answer = request.getParameter("answer");
			System.out.println(answer);
			String lookup = "Update q_a set answer = (?),flag = 1 where userId=(?) and question = (?);";
			PreparedStatement ps = con.prepareStatement(lookup);
			ps.setString(1, answer);
			ps.setInt(2, userId);
			ps.setString(3,question);
			System.out.println(ps);
			int result = ps.executeUpdate();
			if (result > 0) {
				
				System.out.println("Done");
				%>
				<jsp:forward page="answerQuestions.jsp">
				<jsp:param name="message" value="Query submitted successfully!"/> 
				</jsp:forward>
				<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			} else {
				%>
				<jsp:forward page="answerQuestions.jsp">
				<jsp:param name="message" value="Failed!"/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			%>
				<jsp:forward page="answerQuestions.jsp">
				<jsp:param name="message" value="Please enter again!"/> 
				</jsp:forward>
				<%
		}
	%>
</body>
</html>
