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
<title>Albusbook / Profile</title>
<link rel="shortcut icon" type="image/png" href="img/colorworld.png"/>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js?ver=1.4.2"></script>
	<link rel="stylesheet" type="text/css" href="css/AntimCSS.css" /> 
	<script src="js/jquery.color.js"></script>
	<script src="js/script.js"></script>
	<script src="js/main.js"></script>
	<script src="js/jquery-1.10.2.min.js"></script>
	<script   src="booklet/jquery-ui-1.10.4.min.js"></script>	
	<script src="js/portBox.slimscroll.min.js"></script>

	<link href="css/portBox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#mainleftdiv1").load("MainLeftDiv1.jsp");
		$(".areaofnotificationandmessage").load("NotificationAndMessageArea.jsp");
		$("#MidRightData").load("WhoToFollow.jsp");
		
	});
	
	function refreshWhoToFollow()
	{
/*				count++;
		var uid=$("#uidInRefresh").val();
		var limit=count*4;
		$.ajax({
		      type: "POST",
		      url: "refreshServlet",
 		    data: {limit:limit,uid:uid},
     
	         success: function (response) {
			      	 $("#personarea").html(response);
    		 	}
			 }); */
			 
		$("#MidRightData").load("WhoToFollow.jsp");
	}
	
	function followbutton(a)
	{
	 	var send=$("#s"+a).val();
	 	var rec=$("#r"+a).val();
	 	var bname=$("#follow"+a).val();
	 	 $.ajax({
	         type: "POST",
	         url: "followServlet1",
	         data: {sender:send,receiver:rec,buttonname:bname},
	         
	         success: function (data) {
	        	 var result=data.split(";");
	         	$("#follow"+a).val(result[0]);
	         	$("#mainleftdiv1").load("MainLeftDiv1.jsp");
	         	}
	 	 });
	 }
	
	function showLikers(id)
	{
		
		var pid = $("#postId"+id).val();
		$("#paste").load("likedPost.jsp?pid="+pid);
	}
	
	function submitFormForLogout()
	{
		$("#LogoutServlet").submit();
	}
	
	</script>
</head>
<body>

<%
Integer userId = Integer.parseInt(session.getAttribute("user").toString());
int userID=Integer.parseInt(session.getAttribute("searchId").toString());
utilityClass ul = new utilityClass();
Connection con=null;
con = ul.getConnection();
SearchDAO sd = new SearchDAO();
ResultSet rs= sd.getUserByUserId(userId.intValue(), con);
String username=null;
String userpic=null;
String searchPersonName=null;

while(rs.next())
{
	username=rs.getString("fullname");
	userpic=rs.getString("profile_pic");
}

rs.close();
%>


<div id="header">
 	<div id="headercontaint">
		<div class="userpic">
			<img  src="<%=request.getContextPath()%>/uploadedImages/<%=userpic %>" height="30" width="30" style=" float:left" />
		</div>
		<div class="usernameandidarea">
			<div id="username"><label><font><b><%=username %></b></font></label></div>
			<div id="userid"><font><%=userId %></font></div>
		</div>
		<div id="logo">
			<a href="Welcome">
			<img src="img/colorworld.png" height="60" width="60"/>
			</a>
		</div>
		<div id="searchbar">
			<form id="searchForm" action="SearchPerson" method="get">
        		<div class="input">
           			<input type="text" name="s" id="s" value="Search" />
            	</div>
            	<input type="submit" id="searchSubmit" value="" />        
    		</form>
		</div>
		<div id="notificationandmessagearea" class="areaofnotificationandmessage">
			
		</div>
		
		<div id="notificationandmessagearea">
			<div class="notificationiconarea">
				<a href="Settings"><div id="notificationicon"><img title="Settings" src="img/settings.png" height="25" width="25"/></div></a>
			</div>
			<form id="LogoutServlet" action="<%=request.getContextPath() %>/LogoutServlet" method="post">
			<a 	onclick="submitFormForLogout()">
			<div class="messageiconarea">
				<div id="messageicon"><img title="Logout" src="img/Logout.png" height="25" width="25"/></div>
			</div>
			</a>
			</form>
		</div>
	</div>   	
</div>
	<jsp:include page="QuoteOfTheDay.jsp"></jsp:include>

<div id="container">
	<div id="mid">
		<div id="midleft">
			<div id="mainleftdiv1">
				
			</div>
			<div id="mainleftdiv2">
				<div id="booksigncss">Books</div>
				<div style="padding-top: 10px; font-size: 17px; margin-left: 4px; color: #2b7bb9"><a class="a1" href="ShowProfileBook.jsp?searchId=<%=userId %>" >.Profile Book</a></div>
				<div style="padding-top: 5px; font-size: 17px; margin-left: 4px; color: #2b7bb9"><a class="a1" href="<%=request.getContextPath() %>/MessageBook">.Message Book</a></div>
				<div style="padding-top: 5px; font-size: 17px; margin-left: 4px; color: #2b7bb9"><a class="a1" href="<%=request.getContextPath() %>/LifeBook">.Life Book</a></div>
			</div>
		</div>
		<div id="midmid">
			<%
			ResultSet userInfo = (ResultSet)sd.getUserByUserId(userID, con);
			
			while(userInfo.next())
			{
				searchPersonName=userInfo.getString("fullname");
			%>
		
			<div id="showmenubar">
				<div id="menuitem1">
					<div id="profilebookitem"><center><a class="link" href="Profile?action=profilebook&searchId=<%=userID %>"  style="cursor: pointer;">.ProfileBook</a></center></div>
				</div>
				<div id="menuitem2">
					<div id="messagebookitem"><center><a class="link" href="Profile?action=messagebook&searchId=<%=userID %>" style="cursor: pointer;">.Message Book</a></center></div>
				</div>
				<div id="menuitem3">
					<div id="lifebookitem"><center><a class="link" href="Profile?action=lifebook&searchId=<%=userID %>" style="cursor: pointer;">.Life Book</a></center></div>
				</div>
				<div id="menuitem4" class="activehover">
					<div id="messages"><center><a class="link" id="activelink" href="Profile?action=messages&searchId=<%=userID %>" style="cursor: pointer;">Messages</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("messages") %></center></div>
				</div>
				<div id="menuitem5">
					<div id="following"><center><a class="link" href="Profile?action=following&searchId=<%=userID %>" style="cursor: pointer;">Following</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followed") %></center></div>
				</div>
				<div id="menuitem6">
					<div id="followers"><center><a class="link" href="Profile?action=followers&searchId=<%=userID %>" style="cursor: pointer;">Followers</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followers") %></center></div>
				</div>
			</div>
			<%
			}
			%>
			
			<%
			ResultSet myMessages =(ResultSet)sd.getMyMessages(userID,con);
			
			if(!myMessages.next())
			{
			%>
			<div id="nostorydiv">
				<div id="displaytag">
					<center>There are no messages to display</center>
				</div>
			</div>
			<% 
			}
			else
			{
				myMessages.beforeFirst();
			int count=0;
			while(myMessages.next())
			{
				count++;
			%>
			<div id="mainsubmid">	
				<div id="leftpage">
					<div id="bookuserpic"><img  src="<%=request.getContextPath() %>/uploadedImages/<%=myMessages.getString("profile_pic") %>" height="50" width="50" style=" float:left" /></div>
					<div id="bookusernameandid">
						<div id="bookusername"><%=searchPersonName %></div>
						<div id="bookuserid"><%=userID %></div>
					</div>
					<div id="booktextshowarea">
						<div id="bookpage1">
							<label id="p2<%=count %>">
								<textarea class="messagebooktextarea" disabled="disabled"><%=myMessages.getString("page1") %></textarea>	
							</label> 
						</div>
					</div>
					<div id="likearea"> 
						<div id="messagebookcounter">Likes: <a href="#" onmouseover="showLikers(<%=count %>)" data-display="mySite"><b><%=myMessages.getString("likes") %></b></a></div>
					</div>
<!--  				9974386105 -->
				</div>
				<input type="hidden" name="posId" id="postId<%=count%>" value="<%=myMessages.getString("pid") %>">
				<div id="rightpage">
					<div id="bookdateandtimearea">
						<div id="bookdatearea"><%=myMessages.getString("date") %></div>
						<div id="booktimearea"><%=myMessages.getString("time") %></div>
					</div>
					<div id="booktextshowarea">
						<div id="bookpage2">
							<label id="p1<%=count %>">
								<textarea class="messagebooktextarea" disabled="disabled"><%=myMessages.getString("page2") %></textarea> 
							</label> 
						</div>
					</div>
				</div>
			</div>
			
			<%
			}
			}
			
			con.close();
			ul.closeConnection();
			%>
		</div>
		<div id="mySite" class="portBox">
			<div id="paste">
			</div>	
		</div>
		<div id="MidRightData">
		
		</div>
	</div>
</div>

</body>
</html>