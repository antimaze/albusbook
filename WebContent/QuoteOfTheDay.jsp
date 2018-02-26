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

<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="js/portBox.slimscroll.min.js"></script>

	<link href="css/portBox.css" rel="stylesheet" type="text/css" />
</head>
<body>

<%
utilityClass ul = new utilityClass();
Connection con=null;
con = ul.getConnection();
SearchDAO sd = new SearchDAO();

%>

<div id="subheader">
		<div id="subheadercontaint">
			<div id="subheaderbookpic">
				<a href="#" data-display="mySiteee"><img  src="img/book-icon.png" height="25px" width="25px"/></a>
			</div>
		</div>
	</div>
	<div id="mySiteee" class="portBox">
			<%
			ResultSet quote = (ResultSet) sd.getQuoteOfTheDay(con);
			
			while(quote.next())
			{
			%>
			<div id="signforquote">Quote Of The Day</div>
			<textarea id="quoteoftheday" disabled="disabled"><%=quote.getString("quote") %></textarea>
			<%
			}
			
			
			con.close();
			ul.closeConnection();
			%>
	</div>


</body>
</html>