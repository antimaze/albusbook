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
<title>Albusbook / Search Pearson</title>
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
	
	function submitFormForLogout()
	{
		$("#LogoutServlet").submit();
	}
	
	</script>

</head>
<body>

<%
Integer userId = Integer.parseInt(session.getAttribute("user").toString());

String searchName = request.getAttribute("searchname").toString();

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
		
			<div id="showmenubar">
				<div id="messagebooksignarea">
					<label>/ Searched Person(s)</label>
				</div>
			</div>
			
			<%
			int counter=0;
			SearchPersonDAO spd = new SearchPersonDAO();
			ResultSet searchPersonData =(ResultSet) spd.getSearchUser(searchName,userId.intValue(), con);
			
			if(!searchPersonData.next())
			{
			%>
			<br>
			<div id="nostorydiv">
				<div id="displaytag">
					<center>No results found.</center>
				</div>
				<div id="displayanothertag">
					<center>"Search again using User Id, Name or Email."</center>
				</div>
			</div>
			<%
			}
			else
			{
				searchPersonData.beforeFirst();
			while(searchPersonData.next())
			{
				String lable;
				counter++;
				
				if(searchPersonData.getObject("lable")==null)
					lable="Follow";
				else
					lable=searchPersonData.getString("lable");
				
			%>
			
			<div class="followerbox" id="fbox<%=counter %>">
				<div id="followerpic">
					<img  src="<%=request.getContextPath() %>/uploadedImages/<%=searchPersonData.getString("profile_pic") %>" height="50" width="50" style=" float:left" />
				</div>
				<div id="followernameandid">
					<div id="followername"><a class="a1" href="ShowProfileBook.jsp?searchId=<%=searchPersonData.getString("uid") %>" ><%=searchPersonData.getString("fullname") %></a></div>
					<div id="followerid"><%=searchPersonData.getString("uid") %></div>
				</div>
				<div id="followerdetails">
					<div id="messagearea">
						<div id="follower-messages">MESSAGES</div>
						<div id="follower-counter"><%=searchPersonData.getString("messages") %></div>
					</div>
					<div id="followersarea">
						<div id="follower-followers">FOLLOWER</div>
						<div id="follower-counter"><%=searchPersonData.getString("followers") %></div>
					</div>
					<div id="followingarea">
						<div id="follower-following">FOLLOWING</div>
						<div id="follower-counter"><%=searchPersonData.getString("followed") %></div>
					</div>
				</div>
				<%
				if(searchPersonData.getObject("bio") != null)
				{
				%>
				<div id="followerbio">
					<textarea id="followertextarea" disabled="disabled"><%=searchPersonData.getString("bio") %></textarea>
				</div>
				<%
				}
				else
				{
				%>
				<div id="followerbio">
					<textarea id="followertextarea" disabled="disabled"></textarea>
				</div>
				<%
				}
				%>
				<%
				if(Integer.parseInt(searchPersonData.getString("uid")) != userId)
				{
				%>
				<div id="followbutton1">
					<form id="form1" name=form1>
						<input type="hidden" name="follower" value="<%=userId %>" id="s<%=counter %>"/>
						<input type="hidden" name="followed" value="<%=searchPersonData.getString("uid") %>" id="r<%=counter %>"/>
						<input type="button" name="follow<%=counter %>" id="follow<%=counter %>" class="history1" value="<%=lable %>" onclick="followbutton(<%=counter %>)"  >
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