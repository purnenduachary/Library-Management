<html>
<body>
    <h2>Jersey RESTful Web Application!</h2>
    <p><a href="webapi/myresource">Jersey resource</a>
    <p>Visit <a href="http://jersey.java.net">Project Jersey website</a>
    for more information on Jersey!
    
    <jsp:useBean id="lmpbook" class="com.lmp.model.BookModel"/>
<jsp:useBean id="lmpdao" class="com.lmp.dao.LibraryDaoImpl"/>
<jsp:setProperty property="*" name="lmpbook"/>

<%=lmpdao.addBooks(lmpbook) %>
</body>
</html>
