<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List"%>
<%@page import="VO.User"%>
<%@page import="java.util.Date"%>
<%@page import="DAO.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/AntimCSS.css" /> 

<title>Insert title here</title>
</head>
<body>

<%
String password = (String)session.getAttribute("user");
utilityClass ul = new utilityClass();
Connection con=null;
con = ul.getConnection();
SearchDAO sd = new SearchDAO();

ResultSet rs = (ResultSet)sd.getNumberOfUsers(con,password);

while(rs.next())
{
%>
Total number of Users: <%=rs.getString("totalusers") %><br>
Total number of Users: 1200000000
<%
}
%>

<form action="<%=request.getContextPath() %>/UpdateQuote" method="post">
<textarea rows="10" cols="40" id="quoteoftheday" name="quote"></textarea>
<br>
<input type="submit" name="update" value="Update">
</form>

</body>
</html>