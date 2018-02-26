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
<title>Insert title here</title>
</head>
<body>

<%
Integer userID = Integer.parseInt(session.getAttribute("user").toString());
utilityClass ul = new utilityClass();
Connection con=null;
con = ul.getConnection();
SearchDAO sd = new SearchDAO();
ResultSet rs= sd.getUserByUserId(userID.intValue(), con);
String username=null;
String userpic=null;
while(rs.next())
{
	username=rs.getString("fullname");
	userpic=rs.getString("profile_pic");
}

rs.close();

%>


			<%
			ResultSet userInfo = (ResultSet)sd.getUserByUserId(userID, con);
			
			while(userInfo.next())
			{
				userInfo.updateRow();
			%>
		
			<div id="showmenubar">
				<div id="menuitem1" class="activehover">
					<div id="profilebookitem"><center><a class="link" id="activelink" href="ShowProfileBook.jsp?searchId=<%=userID %>"  style="cursor: pointer;">.ProfileBook</a></center></div>
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
						<div id="showprofileimage" class="loadprofilepicture">
							<img id="img" alt="<%=userInfo.getString("profile_pic") %>" src="<%=request.getContextPath()%>/uploadedImages/<%=userInfo.getString("profile_pic") %>" height="300px" width="300px;">
						</div>
						<form>
						<input type="hidden" id="uid" name="uid" value="<%=userID %>"  />
						<div id="editbutton"><input type="button" class="history" name="editprofile" value="Edit Profile" onclick="editProfile1()"></div>											
						</form>
					</div>
				</div>
				<div id="rightpage">
					<div id="profilebookpicshowarea">
						<div id="profilebookpage2">
							<div id="profilebooknamearea">
								<div id="profilebookname"><font size="6"><b><label id="fullname"><%=userInfo.getString("fullname") %></label></b></font></div>
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
							<img alt="<%=userInfo.getString("profile_pic") %>" src="<%=request.getContextPath() %>/uploadedImages/<%=userInfo.getString("profile_pic") %>" id="imagePreview" height="300px" width="300px;" style="cursor: pointer;">
							</label>
							
							<input id="file-input" name="image" type="file" style="display: none;"/>
						</div>
						<input type="hidden" id="uid" name="uid" value="<%=userID %>"  />
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
							<div id="editlivesin">
								<input class="css-inputforusername" name="oldpassword" placeholder=" Lives in" required="" type="text" tabindex="5" maxlength="30" value="<%=userInfo.getString("livesin") %>">
							</div>
							<div id="editbio">								
									<textarea id="biotextarea" name="biotextarea" placeholder="Bio" maxlength="160"><%=userInfo.getString("bio") %></textarea>
							</div>
							<div id="editstatus">
									<textarea id="biotextarea" name="statustextarea" placeholder="Status" maxlength="140"><%=userInfo.getString("status") %></textarea>
							</div>
						</div>
					</div>
				</div>
			</form>
			</div>
			
			<%
			}
			
			con.close();
			ul.closeConnection();
			%>


</body>
</html>