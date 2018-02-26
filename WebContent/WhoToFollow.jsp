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
%>


<%
		ResultSet whoToFollow =(ResultSet) sd.getWhoToFollow(userId,con);
		if(!whoToFollow.next())
		{
			
		}
		else
		{
			whoToFollow.beforeFirst();
		%>
		<div id="midright">
			<div id="title"><center>Who To Follow</center></div>
			<div id="refresharea">
				<form>
					<input type="hidden" name="uid" id="uidInRefresh" value="<%=userId %>" />
					<div id="refresh"><a style="cursor: pointer;" onclick="refreshWhoToFollow()">.Refresh</a></div>
				</form>
				<form id="the_form" action="WhoToFollow" method="post" >
					<div id="viewall"><a href="javascript:{}" onclick="document.getElementById('the_form').submit(); return false;">.View All</a></div>
				</form>
			</div>
			
			<br>
			<%
			int counter=0;
			while(whoToFollow.next())
			{
				counter++;
			%>
		
			<div id="person">
				<div id="personpic"><img  src="<%=request.getContextPath() %>/uploadedImages/<%=whoToFollow.getString("profile_pic") %>" height="40" width="40" style=" float:left" /></div>
				<div id="personnameandid">
					<div id="personname"><a class="a1" href="Profile?action=profilebook&searchId=<%=whoToFollow.getString("uid") %>" ><%=whoToFollow.getString("fullname") %></a></div>
					<div id="personid"><%=whoToFollow.getString("uid") %></div>
				</div>
				<div id="followbutton">
					<input type="hidden" name="follower" value="<%=userId %>" id="s<%=counter %>"/>
					<input type="hidden" name="followed" value="<%=whoToFollow.getString("uid") %>" id="r<%=counter %>"/>
					<input type="button" class="history1" name="follow<%=counter %>" id="follow<%=counter %>" value="Follow" onclick="followbutton(<%=counter %>)">
				</div>
			</div>
			
			<%
			}
			whoToFollow.close();
			ul.closeConnection();
			%>
		</div>
		<%
		}
		%>
		<div id="aboutandcontactus">
			<div id="copyr">&copy 2016 Albusbook</div>
			<div id="about"><a href="<%=request.getContextPath() %>/About">About</a></div>
			<div id="contactus"><a href="<%=request.getContextPath() %>/ContactUs">Contact us</a></div>
		</div>


</body>
</html>