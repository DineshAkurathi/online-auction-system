<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
/* form {border: 3px solid #f1f1f1;} */

input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

button {
  background-color: #333;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 20%;
}

button:hover {
  opacity: 0.8;
  background-color: #04AA6D;
}

.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
}

img.avatar {
  width: 10%;
  border-radius: 12%;
}

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

li {
  float: left;
}

li a {
  display: block;
  color: white;
  text-align: center;
  padding: 12px 14px;
  text-decoration: none;
}
li {
  display: block;
  color: white;
  text-align: center;
  padding: 12px 14px;
  text-decoration: none;
}
button {
  background-color: #333;
  color: white;
  padding: 10px 5px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 20%;
  margin-right: 10px
}

button:hover {
  opacity: 0.8;
  background-color: #04AA6D;
}
li a:hover {
  background-color:  #04AA6D;
}


/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
</style>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<ul>
  <li><a class="active" href="loginSupport.jsp?">Home</a></li>
  <li><a class="active" href="deleteAuctions.jsp">Delete Auctions</a></li>
  <li><a class="active" href="deleteBids.jsp?">Delete Bids</a></li>
  <li><a href="answerQuestions.jsp">Q/A Support</a></li>
  <li style="float:right"><a class="active" href="login.jsp">Logout</a></li>
</ul>
	<div align="center">
		<h1>Edit/Delete Account Information</h1>
 
		<form action="editInfo.jsp" method="post">
		  <div class="container">
			<table style="with: 100%">
			<tr>
					<td>Enter User Id:</td>
					<td><input type="text" name="id" required></td>
				</tr>
				<tr>
					<td>Enter Username:</td>
					<td><input type="text" name="username" required></td>
				</tr>

			</table>
			<button type="submit" name="action" value="edit">Edit Details</button>
			<button type="submit" name="action" value="delete">Delete</button>
			<div style="color:red">${param.message}</div>
		</form>
	</div>
</body>
</html>