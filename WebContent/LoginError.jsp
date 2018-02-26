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

$(document).ready(function(){
	$('#submit1').click(function(){

	var emailValidation = /^[A-Za-z0-9._]*\@[A-Za-z]*\.[A-Za-z]{2,5}$/;
	var fullname = $("#fullname").val();
	var email =$("#email").val();
	var password =$("#password").val();
	var cpassword =$("#cpass").val();
	var date =$("#date").val();
	var month =$("#month").val();
	var year =$("#year").val();
	
	if(fullname == "" || $.trim(fullname)== "")
	{
		$("#fullname").focus();
		$("#errorBox").html("Enter Fullname");
		return false;
	}

	if(email == "" || $.trim(email) == "")
	{
		$("#email").focus();
		$("#errorBox").html("Enter Email");
		return false;
	}
	
	if(!emailValidation.test(email))
	{
		$("#email").focus();
		$("#errorBox").html("Enter Valid Email");
		return false;
	}
	
	if(password == "" || $.trim(password)=="")
	{
		$("#password").focus();
		$("#errorBox").html("Enter fair Password");
		return false;
	}
	
	if(cpassword == "" || $.trim(cpassword)=="")
	{
		$("#cpass").focus();
		$("#errorBox").html("Enter Confirm Password");
		return false;
	}
	
	if(password != cpassword)
	{
		$("#password").focus();
		$("#cpass").focus();
		$("#errorBox").html("Password Mismatch");
		return false;
	}
	
	});
});

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
				<div id="leftpage1">
					<div class="right">
	  					<form id="send" action="<%=request.getContextPath() %>/registration" method="post"> 		 
				 			<label style="overflow: hidden;"> <h2>Sign UP </h2></label>
				 			<div id="errorBox"></div>
    						<div><input class="css1-inputforlogin" name="fullname" id="fullname" placeholder="Full Name" maxlength="20" type="text" tabindex="3"></div>
    						<div style="margin-top: 5px;"><input class="css1-inputforlogin" name="email" id="email" placeholder="example@domain.com" type="text" tabindex="3"></div>
    						<div style="margin-top: 5px;"><input class="css1-inputforlogin"type="password" id="password" name="password" placeholder="password" tabindex="4" ></div> 
    						<div style="margin-top: 5px;"><input class="css1-inputforlogin" type="password" id="cpass"  name="cpass" placeholder="confirm password" tabindex="5"></div> 
				 			<br>
                    		<div style="margin-top: 5px;"><label>Birthday
                    		</label><br></div>
                    		<div style="margin-top: 5px;">
                    		<select class="css-p3" name="day" id="date">
                        	<%
                        	for(int i=1;i<32;i++)
                        	{
                        	%>
                        	<option><%=i %>
                        	</option>
                        	<%
                        	}
                        	%>
                    		</select>
                    		<select class="css-p3" name="month" id="month">
                        	<option value="Jan">January
                        	</option>
                        	<option value="Feb">February
                        	</option>
                        	<option value="Mar">March
                        	</option>
                        	<option value="Apr">April
                        	</option>
                        	<option value="May">May
                        	</option>
                        	<option value="Jun">June
                        	</option>
                        	<option value="jul">July
                        	</option>
                        	<option value="Aug">August
                        	</option>
                        	<option value="Sept">September
                        	</option>
                        	<option value="Oct">October
                        	</option>
                        	<option value="Nov">November
                        	</option>
                        	<option value="Dec">December
                        	</option>
                    		</select>
                    		<select class="css-p3" name="year" id="year" >
                    		<%
                    		for(int i=2016;i>1900;i--)
                    		{
                    		%>
                    		<option><%=i %></option>
                    		<%
                    		}
                    		%>
                    		</select>
                    		</div>
                    		<div style="margin-top: 5px;">
                    		<input type="radio" id="sex" value="male" name="sex" checked="checked" />
                    		<label>Male</label>
                    		<input type="radio" id="sex" value="female" name="sex"/>
                    		<label>Female</label>
                    		</div>
    						<br>
            				<input class="myButton" type="submit" id="submit1" name="submit1" tabindex="5" value="Get Started"> 	 
	 					</form> 
	  				</div>
	  				<div class="right1">
	  					<center><label style="font-size: 24px;">"More You Know,,,More You Will Confuse..."</label></center>
	  				</div>
				</div>
				<div id="rightpage1">
					<div class="right">
						<form id="send" action="<%=request.getContextPath() %>/loginServlet" method="post"> 
							<label style="overflow: hidden;"> <h2>Login </h2></label>
							<font style="color: red">The password or email you have entered is incorrect.</font>
							<div style="margin-top: 5px;"><input class="css1-inputforlogin" name="emailid" placeholder="example@domain.com" required="" type="text" tabindex="5"></div>
					    	<div style="margin-top: 5px;"><input class="css1-inputforlogin"type="password" name="psw" placeholder="password" required="" tabindex="6" ></div>
					    	<div style="margin-top: 5px;"><a href="ForgetPassword.jsp">Forget your password???</a><br></div>
							<div style="margin-top: 5px;"><input class="myButton" name="submit" tabindex="7" value="Login" type="submit"></div> 	 
						</form>
					</div> 
					<div class="right1">
						<label style="font-size: 26px;">About</label><br>
						<label>Albusbook is a community of readers and writers that provides you and others books to fill out by giving answer of a simple questions written in the books.</label>
						<label><b></b></label><br>
					</div>
					<div class="right1">
						<label id="copyr1">&copy 2016 Albusbook</label>
					</div>
				</div>
			</div>
		</div> 
	</div>
</div>

</body>
</html>