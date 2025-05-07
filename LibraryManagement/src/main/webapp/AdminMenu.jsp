<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style type="text/css">
.logout {
	margin-top: -20px;
	margin-left: 290px;
	height: 30px;
}

.aone {
	margin-top: 6px;
	margin-left: 0px;
	height: 38px;
	width: 650px;
	color: #d56d2d;
}

.atwo {
	margin-top: 4px;
	margin-left: 10px;
	height: 30px;
	width: 150px;
	color: #7464aa;
}
</style>
</head>
	<br />
	<%
	String user = (String) session.getAttribute("user");
	out.println("Welcome <b>" + user + "</b>");
	%>
	<br />
	<br />
	<div class="logout">
		<input type="button" name="logout" value="Logout"
			onclick="window.location='index.html'">
	</div>
	<div class="aone" style="background-color: #ff11ff">
		<div class="atwo" style="background-color: #ffff00">
			<a href="AddBooks.jsp">Add Books</a>
		</div>
		<div class="atwo"
			style="background-color: #ffff00; margin-top: -30px; margin-left: 170px">
			<a href="Search.jsp">Search / Issue</a>
		</div>
		<div class="atwo"
			style="background-color: #ffff00; margin-top: -30px; margin-left: 330px">
			<a href="Return.jsp">Return</a>
		</div>
		<div class="atwo"
			style="background-color: #ffff00; margin-top: -30px; margin-left: 490px">
			<a href="ReturnHistory.jsp">History</a>
		</div>
	</div>
</body>
</html>