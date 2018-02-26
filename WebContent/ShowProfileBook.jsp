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
<title>Albusbook / Profile</title>
<link rel="shortcut icon" type="image/png" href="img/colorworld.png"/>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js?ver=1.4.2"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/AntimCSS.css" /> 
	<script src="js/jquery.color.js"></script>
	<script src="js/script.js"></script>
	<script src="js/main.js"></script>
	<script src="booklet/jquery.easing.1.3.js" type="text/javascript"></script>
	<script src="booklet/jquery.booklet.1.1.1.js" type="text/javascript"></script>
	<link href="booklet/jquery.booklet.1.1.0.css" type="text/css" rel="stylesheet" media="screen" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
	
	
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
	
	function editProfile()
	{
	var uid=$("#uid").val();
	
		$.ajax({
	         type: "POST",
	         url: "editProfile",
	         data: {uid:uid},
	         success: function (response) {
	        	 $("#mainsubmid").html(response);
	         	}
	 	 });
	}

	
	$(function() {
		   $('a.link').click(function() {
			   $('#activelink').removeAttr('id');
		       $('a.link').removeClass('active');
		       $('a.link').css({'cursor' :"pointer"});
		       $(this).addClass('active');
		       $(this).css({'cursor' :"default"});
		   });
		});
	
	
	function editProfile1()
	{
		$(".editprofile").hide();
		$(".savechanges").show();
	}
	
	function cancel()
	{
		$(".editprofile").show();
		$(".savechanges").hide();
		$(".userpic").load("LoadProfilePicture.jsp");
		$(".loadprofilepicture").load("LoadProfilePicture1.jsp");
		$("#loadimage").load("LoadProfilePicture3.jsp");
	}
	
	
	function readURL(input)
	{	
		if (input.files && input.files[0]) 
		{
	        var reader = new FileReader();
	        reader.onload = function (e) 
	        {
	            $('#imagePreview').attr('src', e.target.result);
	            $('#img').attr('src', e.target.result);
	            $('#img1').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}

	$(document).on('change','#file-input',function(){
	    readURL(this);

	});

	
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
			<img id="img1"  src="<%=request.getContextPath()%>/uploadedImages/<%=userpic %>" height="30" width="30" style=" float:left" />
		</div>
		<div class="usernameandidarea">
			<div id="username"><b><label id="setusername"><%=username %></label></b></div>
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
		<%
		if(userID==userId)
		{
		%>
		<div id="midmid">
			<%
			ResultSet userInfo = (ResultSet)sd.getUserByUserId(userID, con);
			
			while(userInfo.next())
			{
				userInfo.refreshRow();
			%>
		
			<div id="showmenubar">
				<div id="menuitem1" class="activehover">
					<div id="profilebookitem"><center><a class="link" id="activelink" href="Profile?action=profilebook&searchId=<%=userId %>"  style="cursor: pointer;">.ProfileBook</a></center></div>
				</div>
				<div id="menuitem2">
					<div id="messagebookitem"><center><a class="link" href="Profile?action=messagebook&searchId=<%=userId %>" style="cursor: pointer;">.Message Book</a></center></div>
				</div>
				<div id="menuitem3">
					<div id="lifebookitem"><center><a class="link" href="Profile?action=lifebook&searchId=<%=userId %>" style="cursor: pointer;">.Life Book</a></center></div>
				</div>
				<div id="menuitem4">
					<div id="messages"><center><a class="link" href="Profile?action=messages&searchId=<%=userId %>" style="cursor: pointer;">Messages</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("messages") %></center></div>
				</div>
				<div id="menuitem5">
					<div id="following"><center><a class="link" href="Profile?action=following&searchId=<%=userId %>" style="cursor: pointer;">Following</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followed") %></center></div>
				</div>
				<div id="menuitem6">
					<div id="followers"><center><a class="link" href="Profile?action=followers&searchId=<%=userId %>" style="cursor: pointer;">Followers</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followers") %></center></div>
				</div>
			</div>
			
			
			<div class="editprofile" id="mainsubmid" >
				<div id="leftpage">
					<div id="profilebookpage1">
						<div id="showprofileimage" class="loadprofilepicture">
							<img id="img" alt="<%=userInfo.getString("profile_pic") %>" src="<%=request.getContextPath()%>/uploadedImages/<%=userInfo.getString("profile_pic") %>" height="300px" width="300px;">
						</div>
						<form>
						<input type="hidden" id="uid" name="uid" value="<%=userId %>"  />
						<div id="editbutton"><input type="button" class="history2" name="editprofile" value="Edit Profile" onclick="editProfile1()"></div>											
						</form>
					</div>
				</div>
				<div id="rightpage">
					<div id="profilebookpicshowarea">
						<div id="profilebookpage2">
							<div id="profilebooknamearea">
								<div id="profilebookname"><font><b><label id="fullname1"><%=userInfo.getString("fullname") %></label></b></font></div>
								<div id="profilebookid"><font size="5"><b><%=userID %></b></font></div>
							</div>
							<div id="profilebookbirthday">
								<font size="3">Born on <label id="month"><%=userInfo.getString("month") %></label> <label id="day"><%=userInfo.getString("day") %></label>, <label id="year"><%=userInfo.getString("year") %></label></font>
							</div>
							<%
							if(userInfo.getObject("livesin") != null)
							{
							%>
							<div id="profilebooklivesin">
								<font size="3">Lives in <label id="livesin"><%=userInfo.getString("livesin") %></label></font>
							</div>
							<%
							}
							else
							{
							%>
							<div id="profilebooklivesin">
								<font face="sans-serif" size="3"><label id="livesin"></label></font>
							</div>
							<%
							}
							%>
							<%
							if(userInfo.getObject("bio") != null)
							{
							%>
							<div id="profilebookyourbio">
								<textarea id="profilebookbio" disabled="disabled"><%=userInfo.getString("bio") %></textarea>
							</div>
							<%
							}
							else
							{
							%>
							<div id="profilebookyourbio">
								<textarea id="profilebookbio" disabled="disabled"></textarea>
							</div>
							<%
							}
							%>
							<%
							if(userInfo.getObject("status") != null)
							{
							%>
							<div id="profilebookyourstatus">
								<textarea id="profilebookstatus" maxlength="100" disabled="disabled">"<%=userInfo.getString("status") %>"</textarea>
							</div>
							<%
							}
							else
							{
							%>
							<div id="profilebookyourstatus">
								<textarea id="profilebookstatus" maxlength="100" disabled="disabled"></textarea>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
			
			
			
			
			<div class="savechanges" id="mainsubmid" style="display: none;">
			<form name="UploadForm" id="UploadForm" action="<%=request.getContextPath() %>/saveChanges" enctype="multipart/form-data" method="post">
				<div id="leftpage">
					<div id="profilebookpage1">
						<div id="showprofileimage">
							<label id="loadimage" for="file-input">
							<img alt="<%=userInfo.getString("profile_pic") %>" src="<%=request.getContextPath() %>/uploadedImages/<%=userInfo.getString("profile_pic") %>" id="imagePreview" height="300px" width="300px;">
							</label>
							
							<input id="file-input" name="image" type="file" style="display: none;"/>
						</div>
						<div id="editbutton"><input type="submit" class="history2" name="savepassword" value="Save Changes"></div>
						<div id="cancelbutton"><input type="button" class="history2" name="savepassword" value="Cancel" onclick="cancel()"></div>											
					</div>
				</div>
				<div id="rightpage">
					<div id="profilebookpicshowarea">
						<div id="profilebookpage2">
							<div id="editusername"><input class="css-inputforusername" name="oldpassword" required="" type="text" maxlength="20" value="<%=userInfo.getString("fullname") %>"></div>
							<div id="editbirthdate">
								<div id="birthdayarea">Birthday</div>
								<div id="birthdayinput">
									<p>
									<select class="css-p" name="day" id="date">
										<%
										for(int i=1;i<32;i++)
										{
											if(i!=Integer.parseInt(userInfo.getString("day")))
											{
										%>
											<option value="<%=i %>"><%=i %>
                        					</option>
                        				<%
											}
											else
											{
                        				%>
                        					<option value="<%=i %>" selected="selected"><%=i %>
                        					</option>
                        				<%
											}
										}
                        				%>
									</select>
									<select class="css-p1" name="month" id="month">
									
										<%
										if(userInfo.getString("month").equals("January"))
										{
										%>
                        				<option selected="selected" value="January">January</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="January">January</option>
                        				<%
										}
                        				%>
                        				
                        				<%
										if(userInfo.getString("month").equals("February"))
										{
										%>
                        				<option selected="selected" value="February">February</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="February">February</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("March"))
										{
										%>
                        				<option selected="selected" value="March">March</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="March">March</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("April"))
										{
										%>
                        				<option selected="selected" value="April">April</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="April">April</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("May"))
										{
										%>
                        				<option selected="selected" value="May">May</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="May">May</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("June"))
										{
										%>
                        				<option selected="selected" value="June">June</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="June">June</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("July"))
										{
										%>
                        				<option selected="selected" value="July">July</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="July">July</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("August"))
										{
										%>
                        				<option selected="selected" value="August">August</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="August">August</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("September"))
										{
										%>
                        				<option selected="selected" value="September">September</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="September">September</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("October"))
										{
										%>
                        				<option selected="selected" value="October">October</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="October">October</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("November"))
										{
										%>
                        				<option selected="selected" value="November">November</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="November">November</option>
                        				<%
										}
                        				%>
                        				<%
										if(userInfo.getString("month").equals("December"))
										{
										%>
                        				<option selected="selected" value="December">December</option>
                        				<%
										}
										else
										{
                        				%>
                        				<option value="December">December</option>
                        				<%
										}
                        				%>
                    				</select>
                    				<select class="css-p2" name="year" id="year" >
                    				<%
                    				for(int i=2016;i>1900;i--)
                    				{
                    					if(i!=Integer.parseInt(userInfo.getString("year")))
										{
                    				%>
                    					<option value="<%=i %>"><%=i %></option>
                    				<%
										}
                    					else
                    					{
                    				%>
                    					<option value="<%=i %>" selected="selected"><%=i %></option>
                    				<%
                    					}
                    				}
                    				%>
                    				</select>
									</p>
								</div>
							</div>
							<% 
							if(userInfo.getObject("livesin") != null)
							{
							%>
							<div id="editlivesin">
								<input class="css-inputforusername" name="oldpassword" placeholder=" Lives in" type="text" tabindex="5" maxlength="30" value="<%=userInfo.getString("livesin") %>">
							</div>
							<%
							}
							else
							{
							%>
							<div id="editlivesin">
								<input class="css-inputforusername" name="oldpassword" placeholder=" Lives in" type="text" tabindex="5" maxlength="30">
							</div>
							<%
							}
							%>
							<%
							if(userInfo.getObject("bio") != null)
							{
							%>
							<div id="editbio">								
									<textarea id="biotextarea" name="biotextarea" placeholder="Bio" maxlength="160"><%=userInfo.getString("bio") %></textarea>
							</div>
							<%
							}
							else
							{
							%>
							<div id="editbio">								
									<textarea id="biotextarea" name="biotextarea" placeholder="Bio" maxlength="160"></textarea>
							</div>
							<%
							}
							%>
							<%
							if(userInfo.getObject("status") != null)
							{
							%>
							<div id="editstatus">
									<textarea id="biotextarea" name="statustextarea" placeholder="Status" maxlength="140"><%=userInfo.getString("status") %></textarea>
							</div>
							<%
							}
							else
							{
							%>
							<div id="editstatus">
									<textarea id="biotextarea" name="statustextarea" placeholder="Status" maxlength="140"></textarea>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</form>
			</div>
			
			<%
			}
			%>
		</div>
		<%
		}
		else
		{
		%>
		<div id="midmid">
		
			<%
			ResultSet userInfo = (ResultSet)sd.getUserByUserId(userID, con);
			
			while(userInfo.next())
			{
				userInfo.refreshRow();
			%>
		
			<div id="showmenubar">
				<div id="menuitem1" class="activehover">
					<div id="profilebookitem"><center><a class="link" id="activelink" href="ShowProfileBook.jsp?searchId=<%=userId %>"  style="cursor: pointer;">.ProfileBook</a></center></div>
				</div>
				<div id="menuitem2">
					<div id="messagebookitem"><center><a class="link" href="ShowMessageBook.jsp?searchId=<%=userID %>" style="cursor: pointer;">.Message Book</a></center></div>
				</div>
				<div id="menuitem3">
					<div id="lifebookitem"><center><a class="link" href="ShowLifeBook.jsp?searchId=<%=userID %>" style="cursor: pointer;">.Life Book</a></center></div>
				</div>
				<div id="menuitem4">
					<div id="messages"><center><a class="link" href="ShowMessages.jsp?searchId=<%=userID %>" style="cursor: pointer;">Messages</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("messages") %></center></div>
				</div>
				<div id="menuitem5">
					<div id="following"><center><a class="link" href="ShowFollowing.jsp?searchId=<%=userID %>" style="cursor: pointer;">Following</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followed") %></center></div>
				</div>
				<div id="menuitem6">
					<div id="followers"><center><a class="link" href="ShowFollowers.jsp?searchId=<%=userID %>" style="cursor: pointer;">Followers</a></center></div>
					<div id="counter1" style="color:#2b7bb9;"><center><%=userInfo.getInt("followers") %></center></div>
				</div>
			</div>
			
			
			<div class="editprofile" id="mainsubmid" >
				<div id="leftpage">
					<div id="profilebookpage1">
						<div id="showprofileimage">
							<img id="img" alt="<%=userInfo.getString("profile_pic") %>" src="<%=request.getContextPath()%>/uploadedImages/<%=userInfo.getString("profile_pic") %>" height="300px" width="300px;">
						</div>
					</div>
				</div>
				<div id="rightpage">
					<div id="profilebookpicshowarea">
						<div id="profilebookpage2">
							<div id="profilebooknamearea">
								<div id="profilebookname"><b><label id="fullname"><%=userInfo.getString("fullname") %></label></b></div>
								<div id="profilebookid"><font face="sans-serif" size="5"><b><%=userID %></b></font></div>
							</div>
							<div id="profilebookbirthday">
								<font face="sans-serif" size="3">Born on <label id="month"><%=userInfo.getString("month") %></label> <label id="day"><%=userInfo.getString("day") %></label>, <label id="year"><%=userInfo.getString("year") %></label></font>
							</div>
							<%
							if(userInfo.getObject("livesin") != null)
							{
							%>
							<div id="profilebooklivesin">
								<font face="sans-serif" size="3">Lives in <label id="livesin"><%=userInfo.getString("livesin") %></label></font>
							</div>
							<%
							}
							else
							{
							%>
							<div id="profilebooklivesin">
								<font face="sans-serif" size="3"><label id="livesin"></label></font>
							</div>
							<%
							}
							%>
							<%
							if(userInfo.getObject("bio") != null)
							{
							%>
							<div id="profilebookyourbio">
								<textarea id="profilebookbio" disabled="disabled"><%=userInfo.getString("bio") %></textarea>
							</div>
							<%
							}
							else
							{
							%>
							<div id="profilebookyourbio">
								<textarea id="profilebookbio" disabled="disabled"></textarea>
							</div>
							<%
							}
							%>
							<%
							if(userInfo.getObject("status") != null)
							{
							%>
							<div id="profilebookyourstatus">
								<textarea id="profilebookstatus" maxlength="100" disabled="disabled">"<%=userInfo.getString("status") %>"</textarea>
							</div>
							<%
							}
							else
							{
							%>
							<div id="profilebookyourstatus">
								<textarea id="profilebookstatus" maxlength="100" disabled="disabled"></textarea>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		
		</div>
		<%
		}
		
		con.close();
		ul.closeConnection();
		%>
		<div id="MidRightData">
		
		</div>
	</div>
</div>

</body>
</html>