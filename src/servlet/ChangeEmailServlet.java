package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.ChangeEmailDAO;
import DAO.SearchDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class ChangeEmailServlet
 */
@WebServlet("/ChangeEmailServlet")
public class ChangeEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeEmailServlet() {
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
			RequestDispatcher rd = request.getRequestDispatcher("Settings.jsp");
			rd.forward(request,response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Connection con=null;
		
		PrintWriter o = response.getWriter();
		try {
			con = ul.getConnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SearchDAO sd = new SearchDAO();
		
		String CurrentEmail= request.getParameter("currentEmail");
		String NewEmail = request.getParameter("newEmail");
		HttpSession session = request.getSession(true);
		Integer uid = Integer.parseInt(session.getAttribute("user").toString());
		int userId = uid.intValue();
		
		String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
		Boolean flag1 = CurrentEmail.matches(EMAIL_REGEX);
		Boolean flag2 = NewEmail.matches(EMAIL_REGEX);
 		boolean flag=false;
 		boolean flag4= false;

 		try {
			flag = sd.checkEmail(CurrentEmail, userId, con);
			flag4 = sd.checkEmailWithSystem(NewEmail,con);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
 		if(flag && flag1 && flag2 && flag4)
 		{
 			ChangeEmailDAO ced = new ChangeEmailDAO();
 			try {
				ced.updateEmail(userId, NewEmail, con);
				
				RequestDispatcher rd = request.getRequestDispatcher("ChangeEmail.jsp");
				rd.forward(request, response);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
 		}
 		else
 		{
 			RequestDispatcher rd = request.getRequestDispatcher("ChangeEmail1.jsp");
	 		rd.forward(request,response);
 		}
 		
	}

}
