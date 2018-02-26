<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List"%>
<%@page import="VO.*"%>
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

				Enumeration<String> en = request.getParameterNames();
				int tid = -1;

				
				while(en.hasMoreElements())
				{
					Object obj = en.nextElement();
					String parameter = (String)obj;
					
					if(parameter.equals("tid"))
						tid = Integer.parseInt(request.getParameter("tid"));
				}
				
				ResultSet likersname = (ResultSet)sd.getLikersNameForLifeBook(tid,con);
				
				if(!likersname.next())
				{
				%>
					<p>There are no likes on this post.</p>
				<%
					likersname.close();
				}
				else
				{
					likersname.beforeFirst();
					while(likersname.next())
					{
				%>
				<div id="showLiker">
					<div id="likerImage"><img  src="<%=request.getContextPath() %>/uploadedImages/<%=likersname.getString("profile_pic") %>" height="50" width="50" style=" float:left" /></div>
					<div id="likerNameAndId">
						<div id="likerName"><%=likersname.getString("fullname") %></div>
						<div id="likerId"><%=likersname.getString("uid") %></div>
					</div>
				</div>
				<br>
				
				<%
					}
					likersname.close();
				%>
				<%
				}
				
				con.close();
				ul.closeConnection();
				%>
				

</body>
</html>