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
<title>Albusbook</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" type="image/png" href="img/colorworld.png"/>
	<link rel="stylesheet" type="text/css" href="css/AntimCSS.css" />
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js?ver=1.4.2"></script>
	<link rel="stylesheet" type="text/css" href="css/AntimCSS.css" /> 
	
	<script src="js/jquery.color.js"></script>
	<script src="js/script.js"></script>
	<script src="js/main.js"></script>
	
	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="js/portBox.slimscroll.min.js"></script>

	<link href="css/portBox.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript">
	
		$(document).ready(function(){
			
			$("#midmid").load("NewsFeed.jsp");
			$("#mainleftdiv1").load("MainLeftDiv1.jsp");
			$(".areaofnotificationandmessage").load("NotificationAndMessageArea.jsp");
			$("#MidRightData").load("WhoToFollow.jsp");
			setInterval(function(){
				$("#midmid").load("NewsFeed.jsp");
			}, 240000);
		});
	

		var count=0;

			 function f2(a)
			 {
			 	var liker=$("#l"+a).val();
			 	var post=$("#p"+a).val();
			 	var bname=$("#like"+a).val();
			 	 $.ajax({
	   		      type: "POST",
	  		       url: "likeServlet",
			         data: {sender:liker,receiver:post,buttonname:bname},
	         
	   		      success: function (data1) {
	   		     	 var result1=data1;
	  		      	 var array = result1.split(";");
	  		      	 $("#likes"+a).text(array[1]);
	 	        	$("#like"+a).val(array[0]);
	   		      	}
	 			 });
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
			
			function showLikers(id)
			{
				
				var pid = $("#p"+id).val();
				$("#paste"+id).load("likedPost.jsp?pid="+pid);
			}

			function readMessages()
			{
				var uid=$("#uidInRefresh").val();
				
				$.ajax({
		   		      type: "POST",
		   		      url: "readMessageServlet",
		     		    data: {uid:uid},
		         
				         success: function (response) {
		        		 	}
		 			 });
				
				return false;
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

con.close();
ul.closeConnection();
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

		</div>
		<div id="MidRightData">
		
		</div>
	</div>
</div>
</body>
</html>