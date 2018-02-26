package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import VO.Notifications;
import VO.follow;

import DAO.NotificationDAO;
import DAO.followDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class followServlet
 */
@WebServlet("/followServlet1")
public class followServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public followServlet1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession(true);
		if(session.getAttribute("user") == null)
		{
			response.sendRedirect("Index.jsp");
		}
		else
		{
			RequestDispatcher rd = request.getRequestDispatcher("Welcome.jsp");
			rd.forward(request,response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter o = response.getWriter();
		
		
		utilityClass ul=new utilityClass();
		Connection con=null;
		try {
			con=ul.getConnection();
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		HttpSession session = request.getSession(true);
		Integer uid = Integer.parseInt(session.getAttribute("user").toString());
		int follower = uid.intValue();
		int followed = Integer.parseInt(request.getParameter("receiver"));
		String buttonName = request.getParameter("buttonname");
		String followLable="Following";
		String lable=null;
		followDAO fd;
		int counter1=0;
		
		if(buttonName.equals("Follow"))
		{
			int rowsAffected = 0;
			ResultSet followedCount = null;
			ResultSet followerCount = null;
			follow f = new follow();
			f.setFollower(follower);
			f.setFollowed(followed);
			f.setLable(followLable);
		
			fd = new followDAO();
			try {
				rowsAffected=fd.insert(f,con);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(rowsAffected>0)
			{
				int count=0,counter=0;
				try {
					followedCount=fd.countFollowed(follower,con);
					followerCount=fd.countFollower(followed,con);
					
					while(followedCount.next())
					{
						count=Integer.parseInt(followedCount.getString("total_count").toString());
					}
					while(followerCount.next())
					{
						counter=Integer.parseInt(followerCount.getString("total_count").toString());
					}
					
					fd.updateFollowedCount(follower, count,con);
					fd.updateFollowerCount(followed, counter,con);
					
					followedCount=fd.countFollowed(follower,con);
					while(followedCount.next())
					{
						counter1=Integer.parseInt(followedCount.getString("total_count").toString());
					}

					Notifications no = new Notifications();
					String flag="unread";
					DateFormat dateFormat = new SimpleDateFormat("dd/MMM/yyyy");
					Calendar cal = Calendar.getInstance();
					String date=(String)dateFormat.format(cal.getTime());
					
					no.setUid(followed);
					no.setFollowerid(follower);
					no.setFlag(flag);
					no.setDate(date);
					
					NotificationDAO nod= new NotificationDAO();
					nod.insert(no, con);
					
					followedCount.close();
					followerCount.close();
					ul.closeConnection();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		
			lable="Following";
			o.print(lable);
			o.print(";");
			o.print(counter1);
		}
		else if(buttonName.equals("Following"))
		{
			ResultSet followedCount = null;
			ResultSet followerCount = null;
			fd=new followDAO();
			int result = 0;
			try {
				result = fd.deleteFollowEntry(followed,follower,con);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(result>0)
			{
				int count=0,counter=0;
				try {
					followedCount=fd.countFollowed(follower,con);
					followerCount=fd.countFollower(followed,con);
					
					while(followedCount.next())
					{
						count=Integer.parseInt(followedCount.getString("total_count").toString());
					}
					while(followerCount.next())
					{
						counter=Integer.parseInt(followerCount.getString("total_count").toString());
					}
					
					fd.updateFollowedCount(follower, count,con);
					fd.updateFollowerCount(followed, counter,con);
					
					
					followedCount=fd.countFollowed(follower,con);
					while(followedCount.next())
					{
						counter1=Integer.parseInt(followedCount.getString("total_count").toString());
					}
					
					NotificationDAO nod=new NotificationDAO();
					nod.deleteEntry(followed,follower,con);
					
					
					followedCount.close();
					followerCount.close();
					ul.closeConnection();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				
				lable="Follow";
				
			}
				
			o.print(lable);
			o.print(";");
			o.print(counter1);
		}
	}

}
