<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

	<br>
	<form method="post" action="Login.jsp">
		<center>
			<h2>Please Login:</h2>
			Username: <input type="text" name="username" size="50"><br>
			<br> Password: <input type="password" name="password" size="50"><br>
			<br> <input type="submit" value="Login">
		</center>
	</form>

	<%
	if (request.getParameter("username") != null && request.getParameter("password") != null) {
		String user = request.getParameter("username");
		String pwd = request.getParameter("password");
	%>
	<jsp:useBean id="libuser" class="com.lmp.model.LibUsers" />
	<jsp:setProperty property="*" name="libuser" />
	<jsp:useBean id="libraryDao" class="com.lmp.dao.LibraryDaoImpl" />

	<%
	int count = libraryDao.login(libuser);
	if (count == 1) {
		session.setAttribute("user", user);
	%>
	<jsp:forward page="Menu.jsp" />
	<%
	} else {
	out.println("Invalid Credentials...");
	}
	}
	%>
</body>
</html>
