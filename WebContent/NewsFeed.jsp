<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.Iterator"%>
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
ResultSet rs= sd.getUserByUserId(userId.intValue(), con);
String username=null;
String userpic=null;
while(rs.next())
{
	username=rs.getString("fullname");
	userpic=rs.getString("profile_pic");
}

rs.close();

likesDAO lkd = new likesDAO();
%>



		<%
		ResultSet newsFeed =(ResultSet) sd.getNewsFeed(userId,con);
		
		if(!newsFeed.next())
		{
		%>
		<div id="nostorydiv">
			<div id="displaytag">
				<center>There are no stories to display...</center>
			</div>
			<div id="displayanothertag">
				<center>"You have to follow peoples to receives messages and kept news feed active"</center>
			</div>
		</div>
		<%
		}
		else
		{
		newsFeed.beforeFirst();
		int counter=0;
		ResultSet likes;
		while(newsFeed.next())
		{
			ResultSet likersname= null; 
			String lable;
			counter++;
	
			if(newsFeed.getObject("lable") == null)
				lable="Like";
			else
				lable="Liked";
		%>	
			<div id="mainsubmid">
				<div id="leftpage">
					<div id="bookuserpic"><img  src="<%=request.getContextPath() %>/uploadedImages/<%=newsFeed.getString("profile_pic") %>" height="50" width="50" style=" float:left" /></div>
					<div id="bookusernameandid">
						<div id="bookusername"><a class="a1" id="linkcolor1" href="Profile?action=profilebook&searchId=<%=newsFeed.getString("uid") %>" ><%=newsFeed.getString("fullname") %></a></div>
						<div id="bookuserid"><%=newsFeed.getString("uid") %></div>
					</div>
					<div id="booktextshowarea">
						<div id="bookpage1">
							<textarea class="messagebooktextarea" disabled="disabled"><%=newsFeed.getString("page1") %></textarea> 
						</div>
					</div>
					<div id="likearea">
						<div id="likebutton">
							<form id="form1" name="form1">
								<input type="hidden" value="<%=userId %>" id="l<%=counter %>" />
								<input type="hidden" value="<%=newsFeed.getString("pid") %>" id="p<%=counter %>" />
								<input class="history1" type="button" value=<%=lable %> name="like<%=counter %>" id="like<%=counter %>" onclick="f2(<%=counter %>)" />
							</form>
						</div> 
						<div id="counter" style="font-family: sans-serif;"><b>
							<a href="#" onmouseover="showLikers(<%=counter %>)" data-display="mySite<%=counter %>"><label id="likes<%=counter %>">
							<%
							String pid =newsFeed.getString("pid");
							int postId = Integer.parseInt(pid);

							likes= lkd.countLikes(postId,con);
							while(likes.next())
							{
							%>
							<%=likes.getString("total_likes") %>
							<%
							}
							likes.close();
							%>
							</label></a></b>
						</div>
					</div>
				
				</div>
				<div id="rightpage">
					<div id="bookdateandtimearea">
						<div id="bookdatearea"><%=newsFeed.getString("date") %></div>
						<div id="booktimearea"><%=newsFeed.getString("time") %></div>
					</div>
					<div id="booktextshowarea">
						<div id="bookpage2">
							<textarea class="messagebooktextarea" disabled="disabled"><%=newsFeed.getString("page2") %></textarea> 
						</div>
					</div>
				</div>
			</div>
			<div id="mySite<%=counter %>" class="portBox">
			<div id="paste<%=counter %>">
			</div>	
			</div>
			<%
			}
			}
			newsFeed.close();
			con.close();
			ul.closeConnection();
			%>


</body>
</html>