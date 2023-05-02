<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.login.database.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verify Listing</title>
</head>
<body>
	<%
		try {
			System.out.print("HELLO");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String username = (String) session.getAttribute("username");
			if (username == null) {
				response.sendRedirect("Login.jsp");
			}
			System.out.print(username);
			int auctionId = Integer.parseInt(request.getParameter("auctionId"));
			System.out.print(auctionId);
			String bid = request.getParameter("bid");
		
			int userId = (Integer)session.getAttribute("userId");
			System.out.println("Bid price:"+bid);
			
			if(bid.equals("NONE")){
				%>
				<jsp:forward page="placeBid.jsp">
				<jsp:param name="message" value="You must input a bid."/> 
				<jsp:param name="auctionId" value="<%=auctionId%>"/> 
				</jsp:forward>
			<%  }else {
				
				System.out.println("Checking if bid already exists");
				int bp = Integer.parseInt(bid);
				PreparedStatement check = con.prepareStatement("SELECT bidId from bids where auctionId=? and buyerId=? and bidAmount=?;");
				check.setInt(1, auctionId);
				check.setInt(2, userId);
				check.setFloat(3, bp);
				System.out.println(check);
				ResultSet r = check.executeQuery();
				if(r.next()){
					%>
					<jsp:forward page="placeBid.jsp">
					<jsp:param name="message" value="This bid already exists."/> 
					</jsp:forward>
					<% 
				}
				else{
				System.out.println("Inserting bid");
				String insert = "Insert into bids(auctionId,buyerId,bidAmount) values (?,?,?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setInt(1,auctionId);
				ps.setInt(2,userId);
				ps.setInt(3,bp);
				System.out.println(ps);
				ps.executeUpdate();
				}
				
			}
				%>
			<jsp:forward page="placeBid.jsp">
			<jsp:param name="message" value="Bid success!"/>
			<jsp:param name="auctionId" value="<%=auctionId%>"/>
			</jsp:forward>
			
			<%
		 
		} catch (Exception e) {
			out.print("Unknown exception.");
			%>
			<jsp:forward page="placeBid.jsp">
			<jsp:param name="message" value="Error making bid. Please try again."/> 
			</jsp:forward>
			<% 
		
		}
	%>
</body>
</html>