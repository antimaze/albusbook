package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.likesDAO;
import DAO.utilityClass;
import VO.likes;

/**
 * Servlet implementation class likeServlet
 */
@WebServlet("/likeServlet")
public class likeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public likeServlet() {
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
			RequestDispatcher rd = request.getRequestDispatcher("MessageBook.jsp");
			rd.forward(request,response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Connection con=null;
		utilityClass ul = new utilityClass();
		try {
			con=ul.getConnection();
		} catch (ClassNotFoundException | SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		PrintWriter o = response.getWriter();
		HttpSession session = request.getSession(true);
		Integer userId = Integer.parseInt(session.getAttribute("user").toString());
		int liker = userId.intValue();
		int postId = Integer.parseInt(request.getParameter("receiver"));
		int count=0;
		
		String buttonName = request.getParameter("buttonname");
		String likeLable = "Liked";
		likesDAO lkd=null;
		
		if(buttonName.equals("Like"))
		{
			int rowsAffected = 0;
			
			likes lk = new likes();
			lk.setUid(liker);
			lk.setPostId(postId);
			lk.setLable(likeLable);
			
			lkd= new likesDAO();
			
			try {
				rowsAffected = lkd.insert(lk,con);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(rowsAffected>0)
			{
				
				try {
					ResultSet likeCount = lkd.countLikes(postId,con);
					
					
					while(likeCount.next())
					{
						count=Integer.parseInt(likeCount.getString("total_likes").toString());
					}
					
					lkd.updateLikeCount(postId,count,con);
					ul.closeConnection();
					likeCount.close();
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				likeLable="Liked";
				o.println(likeLable+";");
				o.print(count);
			}
			
		}
		else
		{
			lkd=new likesDAO();
			int result = 0;
			try {
				result=lkd.deleteLikeEntry(liker,postId,con);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(result>0)
			{	
				ResultSet likeCount;
				try {
					likeCount = lkd.countLikes(postId,con);
					
					while(likeCount.next())
					{
						count=Integer.parseInt(likeCount.getString("total_likes").toString());
					}
					
					lkd.updateLikeCount(postId,count,con);
					likeCount.close();
					ul.closeConnection();
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				likeLable="Like";
			}
			
			o.print(likeLable+";");
			o.print(count);
		}
	}

}
