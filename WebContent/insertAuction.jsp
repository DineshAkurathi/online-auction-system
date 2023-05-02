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
	int rs=0;
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			System.out.println("HELLLOOO");
			int userId = (Integer) session.getAttribute("userId");
			System.out.println(userId);
			String brand = request.getParameter("brand");
			String category = request.getParameter("category");
			String itemName = request.getParameter("itemName");
			String color = request.getParameter("color");
			String size = request.getParameter("size");
			String gender = request.getParameter("gender");
			Float price = Float.parseFloat(request.getParameter("listprice"));
			Float reserve = Float.parseFloat(request.getParameter("reserve"));
			Timestamp closeDate = Timestamp.valueOf(request.getParameter("closeDate").replace("T", " ") + ":00");
			System.out.println(brand+category+color);
			PreparedStatement preparedStatement = con.prepareStatement("insert into auctions (sellerId, itemName,reserve,listprice,closeDate, size,color,gender,brand,category,status) values(?,?,?,?,?,?,?,?,?,?,?);");
			preparedStatement.setInt(1, userId);
			preparedStatement.setString(2, itemName);
			preparedStatement.setFloat(3, reserve);
			preparedStatement.setFloat(4, price);
			preparedStatement.setTimestamp(5, closeDate);
			preparedStatement.setString(6, size);
			preparedStatement.setString(7, color);
			preparedStatement.setString(8, gender);
			preparedStatement.setString(9, brand);
			preparedStatement.setString(10, category);
			preparedStatement.setString(10, category);
			preparedStatement.setString(11, "OPEN");
	
		System.out.println(preparedStatement);
		rs  = preparedStatement.executeUpdate();
		System.out.println(rs);

	


			if (rs>0) {
				System.out.println("Success");
				%>
				<jsp:forward page="createListing.jsp">
				<jsp:param name="message" value="Inserted Successfully!"/> 
				</jsp:forward>
				<% //ABOVE: FORWARD TO HOME PAGE WITH CURRENT USERNAME ATTACHED
			} else {
				%>
				<jsp:forward page="createListing.jsp">
				<jsp:param name="message" value="Failed to list auction!"/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			%>
			<jsp:forward page="createListing.jsp">
				<jsp:param name="message" value="Failed to list auction!"/> 
				</jsp:forward>
			<%
		}
	%>
</body>
</html>
