<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Albusbook</title>

<link rel="shortcut icon" type="image/png" href="img/colorworld.png"/>
<link rel="stylesheet" type="text/css" href="css/AntimCSS.css" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js?ver=1.4.2"></script>
 
<script src="booklet/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="booklet/jquery.booklet.1.1.0.min.js" type="text/javascript"></script>
<script src="booklet/jquery.booklet.1.1.0.js" type="text/javascript"></script>
<link href="booklet/jquery.booklet.1.1.0.css" type="text/css" rel="stylesheet" media="screen" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>

<script>

function checkUserID()
{
	var userId = $("#userId").val();
	var email = $("#email").val();
	
	if(jQuery.trim(userId).length == 0)
	{
		$("#showMessage1").css("margin-left","20px");
		 $("#showMessage1").css("color","red");
		 $("#showMessage1").text("Please enter User Id.");
	}
	else if(jQuery.trim(email).length == 0)
	{
	$.ajax({
	      type: "POST",
	      url: "checkUserIDServlet",
		    data: {userId:userId},
 
	         success: function (response) {
	        	 
	        	 if(response == "true")
	        	{
	        		 $("#showMessage1").css("margin-left","20px");
	        		 $("#showMessage1").css("color","green");
	        		 $("#showMessage1").text("");
	        	}
	        	 else
	        	{
	        		 $("#showMessage1").css("margin-left","20px");
	        		 $("#showMessage1").css("color","red");
	        		 $("#showMessage1").text("This userId dosen't exist.");
	        	}
		 	}
		 });
	}
	else
	{
		$.ajax({
		      type: "POST",
		      url: "checkEmailServlet",
			    data: {userId:userId,email:email},
	 
		         success: function (response) {
		        	 
		        	 if(response == "true")
		        	{
		        		 $("#showMessage1").css("margin-left","20px");
		        		 $("#showMessage1").css("color","green");
		        		 $("#showMessage1").text("Everything seems fine.");
		        	}
		        	 else
		        	{
		        		 $("#showMessage1").css("margin-left","20px");
		        		 $("#showMessage1").css("color","red");
		        		 $("#showMessage1").text("User Id dosen't exist or it is not registered email address with this User Id.");
		        	}
			 	}
			 });
	}
}

function checkEmail()
{
	var userId = $("#userId").val();
	var email = $("#email").val();
	
	if(jQuery.trim(userId).length > 0)
	{
	$.ajax({
	      type: "POST",
	      url: "checkEmailServlet",
		    data: {userId:userId,email:email},
 
	         success: function (response) {
	        	 
	        	 if(response == "true")
	        	{
	        		 $("#showMessage1").css("margin-left","20px");
	        		 $("#showMessage1").css("color","green");
	        		 $("#showMessage1").text("Everything seems fine.");
	        	}
	        	 else
	        	{
	        		 $("#showMessage1").css("margin-left","20px");
	        		 $("#showMessage1").css("color","red");
	        		 $("#showMessage1").text("User Id dosen't exist or it is not registered email address with this User Id.");
	        	}
		 	}
		 });
	}
	else
	{
		$("#showMessage1").css("margin-left","20px");
		 $("#showMessage1").css("color","red");
		 $("#showMessage1").text("Please enter User Id.");
	}
}


</script>


</head>
<body id="photo">

<div id="header1">
 	<div id="headercontaint">
		<div id="logoinlogin">
			<img src="img/colorworld.png" height="60" width="60"/>
		</div>
	</div>   	
</div>

<div id="container1">
	<div id="mid1">
		<div id="mainmid">
	  		<div id="mainsubmid1">
	  			<form action="<%=request.getContextPath() %>/ForgetPassword" method="post">
				<div id="leftpage1">
					<div id="headerforforgetpassword">
						<div id="changepasswordsign">Forgot Password</div>
					</div>
					<div id="bodyforforgetpassword">
						<div id="showMessage1"></div>
						<div id="passwordarea">
							<div id="passwordnametag">Enter Your User ID</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" id="userId" name="userId" onchange="checkUserID()" required="" tabindex="5"></div>
						</div>
						<div id="passwordarea1">
							<div id="passwordnametag">Enter Your Email</div>
							<div id="passwordinputtag"><input class="css-inputforpassword" id="email" name="email" onchange="checkEmail()" required="" tabindex="5"></div>
						</div>
						<div id="savepassword">
							<input type="submit" class="history3" id="submit1" name="deleteaccount" value="Reset password">
						</div>
					</div>
				</div>
				</form>
				<div id="rightpage1">
					<div id="bodyforforgetpassword1">
						<div id="tipsignarea1"><center>Can't sign in? Forget Password?</center></div>
						<div id="tipsarea1">
						In order to recover your password, we need to confirm your identity.<br><br>
						Please enter your User ID and registered email address and we'will send you a new password to your email.<br><br><br>
						<font size="2">Return to <a href="Index.jsp">Login</a> page.</font>
						</div>
					</div>
				</div>
			</div>
		</div> 
	</div>
</div>

</body>
</html>