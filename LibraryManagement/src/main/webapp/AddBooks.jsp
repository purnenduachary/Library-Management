<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
</head>
<body>
    <div class="container">
        <h2>Add a New Book</h2>
        <form method="post">
            <label>Book Name:</label>
            <input type="text" name="name" required />

            <label>Author:</label>
            <input type="text" name="author" required />

            <label>Edition:</label>
            <input type="text" name="edition" required />

            <label>Department:</label>
            <input type="text" name="dept" required />

            <label>No. of Copies:</label>
            <input type="number" name="noOfBooks" min="1" required />

            <input type="submit" value="Add Book" />
        </form>

        <%
            if ("post".equalsIgnoreCase(request.getMethod())) {
        %>
            <jsp:useBean id="lmpbook" class="com.lmp.model.BookModel"/>
            <jsp:useBean id="lmpdao" class="com.lmp.dao.LibraryDaoImpl"/>
            <jsp:setProperty property="*" name="lmpbook"/>
            <div class="message">
                <%= lmpdao.addBooks(lmpbook) %>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>
