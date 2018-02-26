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
import DAO.utilityClass;

/**
 * Servlet implementation class refreshServlet
 */
@WebServlet("/refreshServlet")
public class refreshServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public refreshServlet() {
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
		int uid = userId.intValue();				
		int limit = Integer.parseInt(request.getParameter("limit"));		
		ResultSet rs=null;
		SearchDAO sd = new SearchDAO();
		try {
			rs=sd.getWhoToFollowByRefresh(uid, limit, con);
			
			if(!rs.next())
			{
				o.print("There are no more results found...");
			}
			else
			{
				rs.beforeFirst();
				
				while(rs.next())
				{
					o.print("<div>");
					o.print(rs.getString("firstname"));
					o.print(" ");
					o.print(rs.getString("lastname"));
					o.print("<br />");
					o.print(rs.getString("uid"));
					o.print(" ");
					o.print("<input type=\"button\" value=\"follow\" />");
					o.print("<br />");
					o.print("<br />");
				}
			}
			
			
			rs.close();
			ul.closeConnection();
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}

}
