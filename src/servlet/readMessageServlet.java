package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.saveMessages;
import DAO.utilityClass;

/**
 * Servlet implementation class readMessageServlet
 */
@WebServlet("/readMessageServlet")
public class readMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public readMessageServlet() {
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
			RequestDispatcher rd = request.getRequestDispatcher("Messages.jsp");
			rd.forward(request,response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("I am inside readMessageServlet");
		int mid=Integer.parseInt(request.getParameter("mid"));
		HttpSession session = request.getSession(true);
		Integer userId = Integer.parseInt(session.getAttribute("user").toString());
		int uid = userId.intValue();
		
		utilityClass ul=new utilityClass();
		Connection con=null;
		try {
			con=ul.getConnection();
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		saveMessages sm = new saveMessages();
		try {
			sm.readMessages(mid,uid,con);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
	}

}
