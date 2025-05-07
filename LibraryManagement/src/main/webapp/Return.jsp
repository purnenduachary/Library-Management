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
	<jsp:include page="Menu.jsp" />
	<form action="ReturnNext.jsp">
		<table border="3">
			<jsp:useBean id="libDao" class="com.lmp.dao.LibraryDaoImpl" />

			<%
			String username = (String) session.getAttribute("user");
			List<TranBookModel> booklist = libDao.accountDetails(username);
			%>


			<tr>
				<th>Book Id</th>
				<th>User Name</th>
				<th>Issued on</th>
				<th>Return</th>
			</tr>

			<%
			for (TranBookModel tbook : booklist) {
			%>

			<tr>
				<td><%=tbook.getBookId()%></td>
				<td><%=tbook.getUserName()%></td>
				<td><%=tbook.getFromdate()%></td>
				<td><input type="checkbox" name="bookId"
					value=<%=tbook.getBookId()%>></td>
			</tr>
			<%
			}
			%>

		</table>
		<input type="submit" value="Return Book(s)" />
	</form>
</body>
</html>