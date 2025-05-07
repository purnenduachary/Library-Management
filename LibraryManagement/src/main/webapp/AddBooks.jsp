<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f8f8f8;
            margin: 0;
            padding: 0;
        }
        .container {
            background: white;
            width: 50%;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            font-weight: bold;
        }
        input[type=text], input[type=number] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type=submit] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type=submit]:hover {
            background-color: #45a049;
        }
        .message {
            margin-top: 20px;
            color: green;
            font-weight: bold;
            text-align: center;
        }
    </style>
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
