<%@page import="com.lmp.model.BookModel"%>
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
	<jsp:useBean id="libraryDao" class="com.lmp.dao.LibraryDaoImpl" />
	<%
		String searchType = request.getParameter("searchtype");
		String searchValue = request.getParameter("searchvalue");
		List<BookModel> booksList = libraryDao.searchBooks(searchType, searchValue);
	%>
	<form action="Issue.jsp">
	<table border="3" align="center">
	<tr>
			<th>Id</th>
			<th>Name</th>
			<th>Author</th>
			<th>Edition</th>
			<th>Department</th>
			<th>Total Books</th>
			<th>Select</th>
		</tr>
		<%
			for(BookModel book : booksList) {
				int btotal = book.getNoOfBooks();
		%>
			<tr>
				<td> <%=book.getId() %> </td>
				<td> <%=book.getName() %> </td>
				<td> <%=book.getAuthor() %>  </td>
				<td> <%=book.getEdition() %>  </td>
				<td> <%=book.getDept() %> </td>
				<td> <%=book.getNoOfBooks() %> </td>
				<td> 
				<%
					if (btotal > 0) {
				%>
				<input type='checkbox' name='bookid' value=<%=book.getId() %> >
				<%
					}
				%>
				</td>
			</tr>
		<%
			}
		%>
	</table>
	<input type="submit" value="Issue Book(s)" />
	</form>
</body>
</html>