<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<center>
	<form method="post">
		User Name: <input type="text" name="username" /><br></br> Password: <input
			type="password" name="password" /><br></br> Re-type Password: <input
			type="password" name="retypepassword" /><br></br>
			<input type="submit" value="Sign-Up"/>
	</form>
	</center>

	<%
	if(request.getParameter("username")!=null && request.getParameter("password")!=null){
		String pwd = request.getParameter("password");
		String reType = request.getParameter("retypepassword");
		
		if(pwd.equals(reType)){
	}
	%>

	<jsp:useBean id="libUsers" class="com.lmp.model.LibUsers" />
	<jsp:useBean id="libDao" class="com.lmp.dao.LibraryDaoImpl" />
	<jsp:setProperty property="*" name="libUsers" />
	
	<%=libDao.createUser(libUsers) %>
	<%
	
	}
	

%>
<center><br>
<a href="AdminLogin.jsp <b>">Login</a>
</center>



</body>
</html>