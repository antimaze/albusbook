<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List"%>
<%@page import="VO.User"%>
<%@page import="VO.*" %>
<%@page import="java.util.Date"%>
<%@page import="DAO.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Albusbook / Life Book</title>
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
	<script   src="booklet/jquery-ui-1.10.4.min.js"></script>	
	<script src="js/portBox.slimscroll.min.js"></script>

	<link href="css/portBox.css" rel="stylesheet" type="text/css" />
	
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#mainleftdiv1").load("MainLeftDiv1.jsp");
		$(".MainSubMid").load("GetLifeBook.jsp");
		$(".areaofnotificationandmessage").load("NotificationAndMessageArea.jsp");
		$("#MidRightData").load("WhoToFollow.jsp");
		
		
		$("#lifeBook").submit(function(){
			
			$.post("lifeBookServlet",$("#lifeBook").serialize(),function(data){
				$(".MainSubMid").load("GetLifeBook.jsp");
				$("#mainleftdiv1").load("MainLeftDiv1.jsp");
			});
			
			return false;
		});
		
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
	 
	 function deleteMessage(id)
	 {
		 var result = confirm("Do you really want to delete this message?");
		 
		if(result)
		{
			var postId=$("#postId"+id).val();
		 	var userId=$("#uid").val();
		 	
		  	 $.ajax({
		          type: "POST",
		          url: "deleteLifeMessageServlet",
		          data: {postID:postId,userID:userId},
		          
		          success: function (data) {
		         	 
		        	  var array = data.split(":");
		        	  $("#page1"+id).html(array[1]);
			          $("#page2"+id).html(array[0]);

		          	}
		  	 });
		}
	 }

	 
	 function showLikers(id)
		{
			var tid = $("#tid"+id).val();
			$("#paste").load("likedLifePost.jsp?tid="+tid);
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
			<div id="showmenubar">
				<div id="messagebooksignarea">
					<label>.Life Book</label>
				</div>
			</div>
			
			
			<div id="mainsubmid">
			<form name="lifeBook" method="post" id="lifeBook">
				<div id="leftpage">
					<div id="bookuserpic"><img  src="<%=request.getContextPath() %>/uploadedImages/<%=userpic %>" height="50" width="50" style=" float:left" /></div>
					<div id="bookusernameandid">
						<div id="bookusername"><%=username %></div>
						<div id="bookuserid"><%=userId %></div>
					</div>
					<div id="bookwrittenarea">
						<div id="bookpage1">
							<textarea id="messagebookpage1" placeholder="How was your day?" class="booktextarea"  name="text1" ></textarea>
						</div>
					</div>
					<div id="likearea">
						<div id="likebutton">
							<input type="hidden" id="uidinmainsubmid" name="uid" value="<%=userId %>"  />
							<input type="submit" class="history1" name="save" value="Save" />
						</div> 
					</div>
				</div>
				<div id="rightpage">
					<div id="privacyarea">
						<input type="radio" name="privacy" value="public" />Public
						<input type="radio" name="privacy" value="private" checked="checked" />Private
					</div>
					<div id="bookwrittenareainlifebook">
						<div id="bookpage2">
							<textarea id="messagebookpage2" class="booktextarea"  name="text2" ></textarea>
						</div>
					</div>
				</div>	
			</form>		
			</div>
			
			<div id="mainsubmid" class="MainSubMid">
				
			</div>
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