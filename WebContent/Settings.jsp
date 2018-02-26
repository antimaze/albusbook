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
<title>Albusbook / Settings</title>
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
	
	
	
	function cPassword()
	{
		var password = $("#currentPassword").val();
		var userId = $("#userId").val();
		$.ajax({
		      type: "POST",
		      url: "checkPasswordServlet",
 		    data: {password:password,userId:userId},
     
		         success: function (response) {
		        	 
		        	 if(response == "false")
		        	{
		        		 $("#showMessage").css("margin-left","20px");
		        		 $("#showMessage").css("color","red");
		        		 $("#showMessage").text("Incorrect Current Password");
		        	}
		        	 else
		        	{
		        		 $("#showMessage").css("margin-left","20px");
		        		 $("#showMessage").css("color","green");
		        		 $("#showMessage").text("Correct Password");
		        	}
    		 	}
			 });
	}
	
	function cemail()
	{
		var email = $("#currentEmail").val();
		var userId = $("#userId").val();
		$.ajax({
		      type: "POST",
		      url: "checkEmailServlet",
 		    data: {email:email,userId:userId},
     
		         success: function (response) {
		        	 
		        	 if(response == "false")
		        	{
		        		 $("#showMessage1").css("margin-left","20px");
		        		 $("#showMessage1").css("color","red");
		        		 $("#showMessage1").text("Incorrect Current Email");
		        	}
		        	 else
		        	{
		        		 $("#showMessage1").css("margin-left","20px");
		        		 $("#showMessage1").css("color","green");
		        		 $("#showMessage1").text("Correct Email");
		        	}
    		 	}
			 });
	}
	
	function emailvalidate()
	{
		var email = $("#emailindeleteaccount").val();
		var userId = $("#userId").val();
		$.ajax({
		      type: "POST",
		      url: "checkEmailServlet",
 		    data: {email:email,userId:userId},
     
		         success: function (response) {
		        	 
		        	 if(response == "false")
		        	{
		        		 $("#showMessage3").css("margin-left","20px");
		        		 $("#showMessage3").css("color","red");
		        		 $("#showMessage3").text("Incorrect Current Email");
		        	}
		        	 else
		        	{
		        		 $("#showMessage3").css("margin-left","20px");
		        		 $("#showMessage3").css("color","green");
		        		 $("#showMessage3").text("Correct Email");
		        	}
    		 	}
			 });
	}
	
	function passwordvalidate()
	{
		var password = $("#passwordindeleteaccount").val();
		var userId = $("#userId").val();
		$.ajax({
		      type: "POST",
		      url: "checkPasswordServlet",
 		    data: {password:password,userId:userId},
     
		         success: function (response) {
		        	 
		        	 if(response == "false")
		        	{
		        		 $("#showMessage3").css("margin-left","20px");
		        		 $("#showMessage3").css("color","red");
		        		 $("#showMessage3").text("Incorrect Current Password");
		        	}
		        	 else
		        	{
		        		 $("#showMessage3").css("margin-left","20px");
		        		 $("#showMessage3").css("color","green");
		        		 $("#showMessage3").text("Correct Password");
		        	}
    		 	}
			 });
	}
	
	function newemail()
	{
		
		var email = $("#newEmail").val();
		var userId = $("#userId").val();
		$.ajax({
		      type: "POST",
		      url: "checkNewEmailServlet",
 		    data: {email:email,userId:userId},
     
		         success: function (response) {
		        	 
		        	 if(response == "true")
		        	{
		        		 $("#showMessage1").css("margin-left","20px");
		        		 $("#showMessage1").css("color","green");
		        		 $("#showMessage1").text("You can use this email.");
		        	}
		        	 else
		        	{
		        		 $("#showMessage1").css("margin-left","20px");
		        		 $("#showMessage1").css("color","red");
		        		 $("#showMessage1").text("Bad email syntax or it has been already used with system.");
		        	}
    		 	}
			 });
		
	}
	
	function matchPassword()
	{
		var newPassword = $("#newPassword").val();
		var confirmPassword = $("#confirmPassword").val();
		
		if($.trim(newPassword) == "")
		{
			$("#showMessage").css("color","red");
			$("#showMessage").text("Enter Valid Password");
		}
		
		if($.trim(confirmPassword) == "")
		{
			$("#showMessage").css("color","red");
			$("#showMessage").text("Enter Valid Confirm Password");
		}
		
		if(newPassword != confirmPassword)
		{
			$("#showMessage").css("color","red");
			$("#showMessage").text("Password Mismatch");
		}
		
		if(newPassword == confirmPassword)
		{
			$("#showMessage").css("color","green");
			$("#showMessage").text("Password Match");
		}
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
String searchPersonName=null;

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
					<label>/ Settings</label>
				</div>
			</div>
			
			<div id="mainsubmid">
				<div id="leftpage">
					<div id="headerforsettingbook">
						<div id="changepasswordsign">Change Password</div>
					</div>
					<div id="changepasswordarea">
						<div id="showMessage"></div>
						<form action="<%=request.getContextPath() %>/ChangePasswordServlet" method="post">
						<div id="passwordarea">
							<div id="passwordnametag">Current Password</div>
							<input type="hidden" name="userId" id="userId" value="<%=userId %>">
							<div id="passwordinputtag"><input class="css-inputforpassword" id="currentPassword" onchange="cPassword()" name="currentPassword" required="" type="password" tabindex="5"></div>
						</div>
						<div id="passwordarea1">
							<div id="passwordnametag">New Password</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" id="newPassword" onchange="matchPassword()" name="newPassword" required="" type="password" tabindex="5"></div>
						</div>
						<div id="passwordarea1">
							<div id="passwordnametag">Confirm Password</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" id="confirmPassword" onchange="matchPassword()" name="confirmPassword" required="" type="password" tabindex="5"></div>
						</div>
						
						<div id="savepassword">
							<input type="submit" id="submit1" class="history2" name="savepassword" value="Save Changes">
						</div>
						<input type="hidden" name="userId" value="<%=userId %>">
						</form>
					</div>
				</div>
				<div id="rightpage">
					<div id="passwordbookpage2">
						<div id="tipsignarea"><center>Tips for creating strong password</center></div>
						<div id="tipsarea">
						1.Make your password at least 8 character long...<br>
						2.Use a mix of letters, numbers, and special characters...(e.g. @,#)...<br>
						3.Use both uppercase and lowercase characters...<br>
						4.Don't pick a password that you're already using for a different account...<br>
						</div>
						<div id="specialtiparea"><center>"Never tell your password to anyone..."</center></div>
					</div>
				</div>
			</div>
			
			<div id="mainsubmid">
				<div id="leftpage">
					<div id="headerforsettingbook">
						<div id="changepasswordsign">Change Email</div>
					</div>
					<div id="changepasswordarea">
						<div id="showMessage1"></div>
						<form action="<%=request.getContextPath() %>/ChangeEmailServlet" method="post">
						<div id="passwordarea">
							<div id="passwordnametag">Current Email</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" id="currentEmail" onchange="cemail()" name="currentEmail" required="" type="text" tabindex="5"></div>
						</div>
						<div id="passwordarea1">
							<div id="passwordnametag">New Email</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" id="newEmail" onchange="newemail()" name="newEmail" required="" type="text" tabindex="5"></div>
						</div>
						
						<div id="savepassword">
							<input type="submit" id="submit1" class="history2" name="saveemail" value="Save Changes">
						</div>
						<input type="hidden" name="userId" value="<%=userId %>">
						</form>
					</div>
				</div>
				<div id="rightpage">
					<div id="passwordbookpage2">
						<div id="tipsignarea"><center>About Email</center></div>
						<div id="tipsarea">
						Your email is not visible to anyone...<br>
						Use your active email always...<br>
						</div>
					</div>
				</div>
			</div>
			
			<div id="mainsubmid">
				<form action="<%=request.getContextPath() %>/deleteAccountServlet" method="post">
				<div id="leftpage">
					<div id="headerforsettingbook">
						<div id="changepasswordsign">Delete Account</div>
					</div>
					<div id="changepasswordarea">
						<div id="showMessage3"></div>
						<div id="passwordarea">
							<div id="passwordnametag">Enter Your Email</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" onchange="emailvalidate()" id="emailindeleteaccount" name="emailindeleteaccount" required="" type="text" tabindex="5"></div>
						</div>
						<div id="passwordarea1">
							<div id="passwordnametag">Enter Your Password</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" onchange="passwordvalidate()" id="passwordindeleteaccount" name="passwordindeleteaccount" required="" type="password" tabindex="5"></div>
						</div>
						<div id="savepassword">
							<input type="submit" class="history3" name="deleteaccount" value="Delete Account">
						</div>
					</div>
				</div>
				<div id="rightpage">
					<div id="passwordbookpage2">
						<div id="tipsignarea"><center>About Deleting Account</center></div>
						<div id="tipsarea">
						Once you delete your account you will never retrive your account data back...<br>
						You will lost your Message Book and Life Book if you delete your account...<br><br>
						We hardly recommend you to never delete your account...Still you want to delete your account you can do it by clicking on "Delete Account" button shown on first page of this book...
						</div>
						
					</div>
				</div>
				</form>
			</div>

		</div>
		<div id="MidRightData">
		
		</div>
	</div>
</div>

</body>
</html>