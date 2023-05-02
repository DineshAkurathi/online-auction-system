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
			
			String lookup = "SELECT userId,username, password,role FROM user WHERE " 
						+ "username=(?) AND password=(?)";
			PreparedStatement ps = con.prepareStatement(lookup);
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet result = ps.executeQuery();
			if (result.next()) {
				System.out.println("Success");
				System.out.println(result.getString(2));
				session.setAttribute("username", username);
				session.setAttribute("userId", result.getInt(1));
				System.out.println("done");
				String role = result.getString(4);
				System.out.println("Role:"+role);
				if(role.equals("U")){
					
				%>
				<jsp:forward page="loginUser.jsp">
				<jsp:param name="user" value="<%=username%>"/> 
				</jsp:forward>
				<% }else if(role.equals("A")){
					System.out.println("Logged in as Admin");
					%>
					<jsp:forward page="loginAdmin.jsp">
					<jsp:param name="user" value="<%=username%>"/> 
					</jsp:forward>
					<%
				}
				else{
					%>
					<jsp:forward page="loginSupport.jsp">
					<jsp:param name="user" value="<%=username%>"/> 
					</jsp:forward>
					<%
				}
			} else {
				%>
				<jsp:forward page="login.jsp">
				<jsp:param name="message" value="Incorrect username or password."/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			%>
			<jsp:forward page="login.jsp">
			<jsp:param name="message" value="Error logging in. Please try again."/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>
