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
<title>Insert title here</title>
</head>
<body>

<%
Integer userId = Integer.parseInt(session.getAttribute("user").toString());

utilityClass ul = new utilityClass();
Connection con=null;
con = ul.getConnection();
SearchDAO sd = new SearchDAO();
ResultSet rs= sd.getUserByUserId(userId.intValue(), con);
String username=null;
String userpic=null;
while(rs.next())
{
	username=rs.getString("fullname");
	userpic=rs.getString("profile_pic");
}

rs.close();

%>



<%
	ResultSet count= sd.getUserByUserId(userId,con);
	while(count.next())
	{
%>
	<div id="fontstyle"><a id="linkcolor" href="Profile?action=messages&searchId=<%=userId %>" >Messages</a></div>
	<div style="float:left; margin-left: 4px; font-size: 20px; padding-top: 10px; color:#2b7bb9;"><%=count.getString("messages") %></div>
	
	<div id="fontstyle"><a id="linkcolor" href="Profile?action=following&searchId=<%=userId %>" >Following</a></div>
	<div style="float:left; margin-left: 4px; font-size: 20px; padding-top: 10px; color:#2b7bb9"><%=count.getString("followed") %></div>
	
	<div id="fontstyle"><a id="linkcolor" href="Profile?action=followers&searchId=<%=userId %>" >Followers</a></div>
	<div style="float:left; margin-left: 4px; font-size: 20px; padding-top: 10px; color:#2b7bb9"><%=count.getString("followers") %></div>
<%
	}
	count.close();
	con.close();
	ul.closeConnection();
%>

</body>
</html>