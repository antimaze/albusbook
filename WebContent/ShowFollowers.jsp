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
	<script src="booklet/jquery.easing.1.3.js" type="text/javascript"></script>
	<script src="booklet/jquery.booklet.1.1.1.js" type="text/javascript"></script>
	<link href="booklet/jquery.booklet.1.1.0.css" type="text/css" rel="stylesheet" media="screen" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
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
	
	function f2(a)
	{
	 	var send=$("#s"+a).val();
	 	var rec=$("#r"+a).val();
	 	var bname=$("#follow1"+a).val();
	 	 $.ajax({
	         type: "POST",
	         url: "followServlet1",
	         data: {sender:send,receiver:rec,buttonname:bname},
	         
	         success: function (data) {
	        	 var result=data.split(";");
	         	$("#follow1"+a).val(result[0]);
	         	$("#mainleftdiv1").load("MainLeftDiv1.jsp");
	         	$(".ffff").text(result[1]);
	         	}
	 	 });
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
				<div id="menuitem4">
					<div id="messages"><center><a class="link" href="Profile?action=messages&searchId=<%=userID %>" style="cursor: pointer;">Messages</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("messages") %></center></div>
				</div>
				<%
					if(userID==userId)
					{
				%>
				<div id="menuitem5">
					<div id="following"><center><a class="link" href="Profile?action=following&searchId=<%=userId %>" style="cursor: pointer;">Following</a></center></div>
					<center><div id="counter1" class="ffff" style="color:#2b7bb9;"><%=userInfo.getInt("followed") %></div></center>
				</div>
				<%
					}
					else
					{
				%>
				<div id="menuitem5">
					<div id="following"><center><a class="link" href="Profile?action=following&searchId=<%=userID %>" style="cursor: pointer;">Following</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followed") %></center></div>
				</div>
				<%
					}
				%>
				<div id="menuitem6" class="activehover">
					<div id="followers"><center><a class="link" id="activelink" href="Profile?action=followers&searchId=<%=userID %>" style="cursor: pointer;">Followers</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followers") %></center></div>
				</div>
			</div>
			<%
			}
			%>
			
			
			<%
			
			getFollowersDAO gfd = new getFollowersDAO();
			ResultSet followers = (ResultSet) gfd.getFollowers(userID,userId, con);
			String lable=null;
			String bio=null;
			
			if(!followers.next())
			{
			%>
			<div id="nostorydiv">
				<div id="displaytag">
					<center>There are no followers of this user</center>
				</div>
			</div>
			<%
			}
			else
			{
				followers.beforeFirst();
			int counter=0;
			while(followers.next())
			{
				counter++;
				if(followers.getObject("lable") == null)
					lable="Follow";
				else
					lable="Following";
				
				if(followers.getObject("bio") == null)
					bio=" ";
				else
					bio=followers.getString("bio");
				
			
			%>
			
			<div class="followerbox" id="fbox<%=counter %>">
				<div id="followerpic">
					<img  src="<%=request.getContextPath() %>/uploadedImages/<%=followers.getString("profile_pic") %>" height="50" width="50" style=" float:left" />
				</div>
				<div id="followernameandid">
					<div id="followername"><a class="a1" href="Profile?action=profilebook&searchId=<%=followers.getString("follower_id") %>" ><%=followers.getString("fullname") %></a></div>
					<div id="followerid"><%=followers.getString("follower_id") %></div>
				</div>
				<div id="followerdetails">
					<div id="messagearea">
						<div id="follower-messages">MESSAGES</div>
						<div id="follower-counter"><%=followers.getString("messages") %></div>
					</div>
					<div id="followersarea">
						<div id="follower-followers">FOLLOWER</div>
						<div id="follower-counter"><%=followers.getString("followers") %></div>
					</div>
					<div id="followingarea">
						<div id="follower-following">FOLLOWING</div>
						<div id="follower-counter"><%=followers.getString("followed") %></div>
					</div>
				</div>
				<div id="followerbio">
					<textarea id="followertextarea" disabled="disabled"><%=bio %></textarea>
				</div>
				<%
				if(Integer.parseInt(followers.getString("follower_id")) != userId)
				{
				%>
				<div id="followbutton1">
					<form id="form1" name=form1>
						<input type="hidden" name="follower" value="<%=userId %>" id="s<%=counter %>"/>
						<input type="hidden" name="followed" value="<%=followers.getString("follower_id") %>" id="r<%=counter %>"/>
						<input type="button" name="follow1<%=counter %>" id="follow1<%=counter %>" class="history1" value=<%=lable %> onclick="f2(<%=counter %>)"  >
					</form>
				</div>
				<%
				}
				%>
			</div>
			<%
			}
			}
			
			
			con.close();
			ul.closeConnection();
			%>

		</div>
		<div id="MidRightData">
		
		</div>
	</div>
</div>

</body>
</html>