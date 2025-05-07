<%@ page import="java.util.List" %>
<%@ page import="com.lmp.model.TransReturn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction History</title>
</head>
<body>
   
    <jsp:include page="Menu.jsp"></jsp:include>
    <h2 align="center">Return Book History</h2>
    
  <%--   <jsp:useBean id="transDao" class="com.lmp.dao.TransReturnDaoImpl" />  --%>
    
    	<jsp:useBean id="LibraryDao" class="com.lmp.dao.LibraryDaoImpl" />
    
    <%
        List<TransReturn> historyList = LibraryDao.getAllTransactionHistory();
    %>

    <table border="2" align="center" cellpadding="10">
        <tr>
            <th>Username</th>
            <th>Book ID</th>
            <th>From Date</th>
            <th>To Date</th>
        </tr>
        <%
            for (TransReturn tr : historyList) {
        %>
            <tr>
                <td><%= tr.getUsername() %></td>
                <td><%= tr.getBookId() %></td>
                <td><%= tr.getFromDate() %></td>
                <td><%= tr.getToDate() %></td>
                
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>
