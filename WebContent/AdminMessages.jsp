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
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js?ver=1.4.2"></script>

<title>Insert title here</title>

<script type="text/javascript">

function deletemessage(a)
{
 	 $.ajax({
         type: "POST",
         url: "deleteadminmessage",
         data: {sender:a},
         
         success: function (data) {
        	$(".message"+a).remove();
         	}
 	 });
 }	 


</script>

</head>
<body>


<%
String password = (String)session.getAttribute("user");
utilityClass ul = new utilityClass();
Connection con=null;
con = ul.getConnection();
SearchDAO sd = new SearchDAO();

ResultSet rs = (ResultSet)sd.getAdminMessages(con, password);
%>

<a href="AdminWelcome.jsp">Click here to go back.</a>

<%
while(rs.next())
{
%>
<div id="adminmessagebox" class="message<%=rs.getString("id") %>">
<%=rs.getString("fullname") %><br>
<%=rs.getString("email") %><br>
<%=rs.getString("subject") %><br>
<%=rs.getString("id") %><br><br>
<%=rs.getString("message") %><br><br>
<a onclick="deletemessage(<%=rs.getString("id") %>)">delete</a>
</div>
<%
}
%>

</body>
</html>