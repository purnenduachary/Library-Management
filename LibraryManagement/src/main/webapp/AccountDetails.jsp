<%@page import="com.lmp.model.TranBookModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

    <jsp:include page="Menu.jsp"/>
	<jsp:useBean id="libDao" class="com.lmp.dao.LibraryDaoImpl" />

	<%
	String iuser = (String)session.getAttribute("user");
	List<TranBookModel> bookIssued = libDao.accountDetails(iuser);
	%>
	<table border="3" align="center">
		<tr>
			<th>Book Id</th>
			<th>UserName</th>
			<th>From Date</th>
		</tr>
		<%
			for(TranBookModel tbook : bookIssued) {
		%>
		<tr>
			<td><%= tbook.getBookId() %></td>
			<td><%= tbook.getUserName() %></td>
		    <td><%= tbook.getFromdate() %></td>
		    
		</tr>
		<%
			}
		%>
	</table>

</body>
</html>