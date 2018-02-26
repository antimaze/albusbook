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
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js?ver=1.4.2"></script>

	<script src="booklet/jquery.easing.1.3.js" type="text/javascript"></script>
	<script src="booklet/jquery.booklet.1.1.1.js" type="text/javascript"></script>
	<link href="booklet/jquery.booklet.1.1.0.css" type="text/css" rel="stylesheet" media="screen" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
	
	<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="js/portBox.slimscroll.min.js"></script>

	<link href="css/portBox.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
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
%>



				<a id="next_page_button"></a>
				<a id="prev_page_button"></a>
				<div id="mybook" style="display:none;">
					<%
					ResultSet myMessages =(ResultSet)sd.getMyMessages(userId,con);
					%>
					<div class="b-load">
					<%
					int count=0;
					while(myMessages.next())
					{
						count++;
					%>
						<div id="page1<%=count %>" class="messagebookrightpage">
							<div id="messagebookdateandtimearea3">
								<div id="messagebookdatearea"><%=myMessages.getString("date") %></div>
								<div id="messagebooktimearea"><%=myMessages.getString("time") %></div>
							</div>
							<div id="messagebooktextshowarea">
								<div id="bookpage2">
									<label id="p1<%=count %>">
										<textarea class="messagebooktextarea" disabled="disabled"><%=myMessages.getString("page2") %></textarea> 
									</label> 
								</div>
							</div>		
							<div id="messagebookdeletearea">
								<div id="messagebookdeletebutton">
									<form>
										<input type="hidden" name="postId" value="<%=myMessages.getString("pid") %>" id="postId<%=count %>" />
										<input type="hidden" name="uid" value="<%=userId %>" id="uid" />
										<input type="button" class="history1" name="delete" value="Delete" onclick="deleteMessage(<%=count %>)" />
									</form>
								</div> 
							</div>				
						</div>
						<div id="page2<%=count %>" class="messagebookleftpage">
 							<div id="messagebookuserpic"><img  src="<%=request.getContextPath() %>/uploadedImages/<%=myMessages.getString("profile_pic") %>" height="50" width="50" style=" float:left" /></div>
							<div id="messagebookusernameandid">
								<div id="messagebookusername"><%=username %></div>
								<div id="messagebookuserid"><%=userId %></div>
							</div>
							<div id="messagebooktextshowarea">
								<div id="bookpage1">
									<label id="p2<%=count %>">
										<textarea class="messagebooktextarea" disabled="disabled"><%=myMessages.getString("page1") %></textarea>	
									</label> 
								</div>
							</div>
							<div id="messagebooklikearea"> 
								<div id="messagebookcounter">Likes: <a href="#" onmouseover="showLikers(<%=count %>)" data-display="mySite"><b><%=myMessages.getString("likes") %></b></a></div>
							</div>
							
						</div>
						<%
						}
						%>
						<%
						myMessages.close();
							
						con.close();
						ul.closeConnection();
						%>
					</div>
				</div>


<script type="text/javascript">
			$(function() {
				var $mybook 		= $('#mybook');
				var $bttn_next		= $('#next_page_button');
				var $bttn_prev		= $('#prev_page_button');
				

				
							$bttn_next.show();
							$bttn_prev.show();
							$mybook.show().booklet({
								name:               null,                            // name of the booklet to display in the document title bar
								width:              760,                             // container width
								height:             575,                             // container height
								speed:              600,                             // speed of the transition between pages
								direction:          'RTL',                           // direction of the overall content organization, default LTR, left to right, can be RTL for languages which read right to left
								startingPage:       0,                               // index of the first page to be displayed
								easing:             'easeInOutQuad',                 // easing method for complete transition
								easeIn:             'easeInQuad',                    // easing method for first half of transition
								easeOut:            'easeOutQuad',                   // easing method for second half of transition

								closed:             false,                           // start with the book "closed", will add empty pages to beginning and end of book
								closedFrontTitle:   null,                            // used with "closed", "menu" and "pageSelector", determines title of blank starting page
								closedFrontChapter: null,                            // used with "closed", "menu" and "chapterSelector", determines chapter name of blank starting page
								closedBackTitle:    null,                            // used with "closed", "menu" and "pageSelector", determines chapter name of blank ending page
								closedBackChapter:  null,                            // used with "closed", "menu" and "chapterSelector", determines chapter name of blank ending page
								covers:             false,                           // used with  "closed", makes first and last pages into covers, without page numbers (if enabled)

								pagePadding:        10,                              // padding for each page wrapper
								pageNumbers:        false,                            // display page numbers on each page

								hovers:             false,                            // enables preview pageturn hover animation, shows a small preview of previous or next page on hover
								overlays:           false,                            // enables navigation using a page sized overlay, when enabled links inside the content will not be clickable
								tabs:               false,                           // adds tabs along the top of the pages
								tabWidth:           60,                              // set the width of the tabs
								tabHeight:          20,                              // set the height of the tabs
								arrows:             false,                           // adds arrows overlayed over the book edges
								cursor:             'pointer',                       // cursor css setting for side bar areas

								hash:               false,                           // enables navigation using a hash string, ex: #/page/1 for page 1, will affect all booklets with 'hash' enabled
								keyboard:           true,                            // enables navigation with arrow keys (left: previous, right: next)
								next:               $bttn_next,          			// selector for element to use as click trigger for next page
								prev:               $bttn_prev,          			// selector for element to use as click trigger for previous page

								menu:               false,                            // selector for element to use as the menu area, required for 'pageSelector'
								pageSelector:       false,                           // enables navigation with a dropdown menu of pages, requires 'menu'
								chapterSelector:    false,                           // enables navigation with a dropdown menu of chapters, determined by the "rel" attribute, requires 'menu'

								shadows:            true,                            // display shadows on page animations
								shadowTopFwdWidth:  166,                             // shadow width for top forward anim
								shadowTopBackWidth: 166,                             // shadow width for top back anim
								shadowBtmWidth:     50,                              // shadow width for bottom shadow

								before:             function(){},                    // callback invoked before each page turn animation
								after:              function(){}                     // callback invoked after each page turn animation
							});				
			});
</script>


</body>
</html>