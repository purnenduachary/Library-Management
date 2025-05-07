<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form method="post">

		Admin User Name: <input type="text" name="username" /><br></br>
		PassCode: <input type="password" name="passcode" /><br></br> Re-Type
		PassCode: <input type="password" name="retypepasscode" /><br></br> <input
			type="submit" value="Signup" /><br></br>
	</form>

	<%
	if(request.getParameter("username")!=null && request.getParameter("passcode")!=null){
		
		String pwd = request.getParameter("passcode");
		String retype = request.getParameter("retypepasscode");
		if(pwd.equals(retype)){
			
		}
	%>
	
	<jsp:useBean id="admindao" class="com.lmp.model.AdminLogin"/>
	<jsp:useBean id="adminimpl" class="com.lmp.dao.LibraryDaoImpl"/>	
	<jsp:setProperty property="*" name="admindao"/>
	
	<%=adminimpl.createAdmin(admindao) %>
	
	

<%
	}
	 %>

</body>
</html>