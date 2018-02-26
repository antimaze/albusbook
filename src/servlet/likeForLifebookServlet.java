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

import VO.likesForLifebook;

import DAO.LikesForLifebook;
import DAO.utilityClass;

/**
 * Servlet implementation class likeForLifebookServlet
 */
@WebServlet("/likeForLifebookServlet")
public class likeForLifebookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public likeForLifebookServlet() {
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
			RequestDispatcher rd = request.getRequestDispatcher("LifeBook.jsp");
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
		Integer uid = Integer.parseInt(session.getAttribute("user").toString());
		int liker = uid.intValue();
		int topicId = Integer.parseInt(request.getParameter("receiver"));
		int count=0;
		
		String buttonName = request.getParameter("buttonname");
		String likeLable = "Liked";
		
		LikesForLifebook lflb = null;
		if(buttonName.equals("Like"))
		{
			int rowsAffected = 0;
			
			likesForLifebook llb = new likesForLifebook();
			llb.setUid(liker);
			llb.setTopicid(topicId);
			llb.setLable(likeLable);
			
			lflb = new LikesForLifebook();
			
			try {
				rowsAffected = lflb.insert(llb,con);
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
					ResultSet likeCount = lflb.countLikes(topicId,con);
					
					
					while(likeCount.next())
					{
						count=Integer.parseInt(likeCount.getString("total_likes").toString());
					}
					lflb.updateLikeCount(topicId,count,con);
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
			lflb = new LikesForLifebook();
			int result = 0;
			
			try {
				result=lflb.deleteLikeEntry(liker,topicId,con);
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
					likeCount = lflb.countLikes(topicId,con);
					
					while(likeCount.next())
					{
						count=Integer.parseInt(likeCount.getString("total_likes").toString());
					}
					lflb.updateLikeCount(topicId,count,con);
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
