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

import DAO.SearchDAO;
import DAO.followBookDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class deleteMessageServlet
 */
@WebServlet("/deleteMessageServlet")
public class deleteMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteMessageServlet() {
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
		
		utilityClass ul = new utilityClass();
		Connection con=null;
		try {
			con = ul.getConnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int postId = Integer.parseInt(request.getParameter("postID"));
		HttpSession session = request.getSession(true);
		Integer uid = Integer.parseInt(session.getAttribute("user").toString());
		int userId = uid.intValue();
		int rowsAffected=0;
		
		
		SearchDAO sd = new SearchDAO();
		try {
			rowsAffected=sd.deleteMessageByPostId(postId,userId, con);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(rowsAffected>0)
		{
			followBookDAO fbd = new followBookDAO();

			ResultSet messageCount = null;
			int count=0;
			try {
				messageCount=fbd.countMessages(userId,con);
				
				while(messageCount.next())
				{
					count = Integer.parseInt(messageCount.getString("total_messages").toString());
				}
				
				fbd.updateMessageCount(userId, count,con);
				ul.closeConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		o.print("Your message has been deleted...\n");
		o.print("You will not see this message again...");
		
	}

}
