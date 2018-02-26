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

<script type="text/javascript">


</script>

</head>
<body>


<%
Integer userId = Integer.parseInt(session.getAttribute("user").toString());

utilityClass ul = new utilityClass();
Connection con=null;
con = ul.getConnection();
SearchDAO sd = new SearchDAO();

ResultSet recieveMessages = (ResultSet)sd.getRecievedMessages(userId, con);
int count=0;
while(recieveMessages.next())
{
	if(recieveMessages.getString("flag").equals("unread"))
	{
		count++;
%>
<div id="messageareaforsendedreceived" onclick="readMessages(<%=count %>)">
	<input type="hidden" name="mid<%=count %>" id="mid<%=count %>" value="<%=recieveMessages.getString("messageid") %>" >
	<textarea id="messagetextarea" class="style<%=count %>" style="color: #2b7bb9; cursor: pointer;" disabled="disabled"><%=recieveMessages.getString("message") %></textarea>
	<div id="toandsend">
		<div id="fromtag">From:</div>
		<div id="tooo"><font style="font-size: 16px ; font-weight: 600"><%=recieveMessages.getString("fullname") %></font> <%=recieveMessages.getString("messagesender") %></div>
		<div id="dateofMessagearea">
			<div id="dateinmessages"><%=recieveMessages.getString("date") %></div>
			<div id="timeinmessages"><%=recieveMessages.getString("time") %></div>
		</div>
	</div>
</div>

<%
	}
	else
	{
%>
<div id="messageareaforsendedreceived">
	<textarea id="messagetextarea" disabled="disabled"><%=recieveMessages.getString("message") %></textarea>
	<div id="toandsend">
		<div id="fromtag">From:</div>
		<div id="tooo"><font style="font-size: 16px ; font-weight: 600"> <%=recieveMessages.getString("fullname") %></font> (<%=recieveMessages.getString("messagesender") %>)</div>
		<div id="dateofMessagearea">
			<div id="dateinmessages"><%=recieveMessages.getString("date") %></div>
			<div id="timeinmessages"><%=recieveMessages.getString("time") %></div>
		</div>
	</div>
</div>

<%
	}
}
recieveMessages.close();
con.close();
ul.closeConnection();
%>

</body>
</html>