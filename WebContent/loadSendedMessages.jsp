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

ResultSet sendedMessages = (ResultSet)sd.getSendedMessages(userId, con);
while(sendedMessages.next())
{
%>

<div id="messageareaforsendedreceived">
	<textarea id="messagetextarea" disabled="disabled"><%=sendedMessages.getString("message") %></textarea>
	<div id="toandsend">
		<div id="totag">To:</div>
		<div id="tooo1"><font style="font-size: 16px ; font-weight: 600"><%=sendedMessages.getString("fullname") %></font> (<%=sendedMessages.getString("messagereciever") %>)</div>
		<div id="dateofMessagearea">
			<div id="dateinmessages"><%=sendedMessages.getString("date") %></div>
			<div id="timeinmessages"><%=sendedMessages.getString("time") %></div>
		</div>
	</div>
</div>

<%
}

sendedMessages.close();
con.close();
ul.closeConnection();
%>


</body>
</html>