<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>

<%@page import="java.sql.ResultSet"%>
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

%>



<%
			boolean flag = (boolean)sd.getNotifications(userId,con);
			
			if(flag)
			{
			%>
			<a href="Notification"><div class="notificationiconarea"><div  id="notificationicon">
				<img style="position: absolute;" title="Notifications" src="img/notification.png" height="25" width="25"/></div>
				<img style="position: absolute;" class="notificationflag" title="Messages" src="images/red.png" height="10" width="10"/>
			</div></a>
			<%
			}
			else
			{
			%> 
			<a href="Notification"><div class="notificationiconarea">
				<div id="notificationicon"><img title="Notifications" src="img/notification.png" height="25" width="25"/></div>
			</div></a>
			<%
			}
			%>
			
			<%
			boolean flag1 = (boolean)sd.getMessagesFlag(userId, con);
			
			if(flag1)
			{
			%>
			<a href="PersonalMessages"><div class="messageiconarea"><div id="messageicon">
				<img style="position: absolute;" title="Messages" src="img/Message.png" height="25" width="25"/>
				</div>
				<img style="position: absolute;" class="messageflag" title="Messages" src="images/red.png" height="10" width="10"/>
			</div></a>
			<%
			}
			else
			{
			%>
			<a href="PersonalMessages"><div class="messageiconarea">
				<div id="messageicon"><img style="position: absolute;" title="Messages" src="img/Message.png" height="25" width="25"/></div>
			</div></a>
			<%
			}
			
			con.close();
			ul.closeConnection();
			
			%> 


</body>
</html>