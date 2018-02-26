package servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

import DAO.loginDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/Welcome")
public class Welcome extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Welcome() {
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
		Statement st = null;
		try {
			con=ul.getConnection();
			st= ul.utility(con);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
				
		int uid = 0;
		String userId = request.getParameter("emailid");   
	     String password = request.getParameter("psw");
	     loginDAO loginService = new loginDAO();
//	     SearchDAO searchDates = new SearchDAO();
	     
	     
	     StringBuffer stringBuffer = null;
			MessageDigest messageDigest;
	         try {
	             messageDigest = MessageDigest.getInstance("MD5");
	             messageDigest.update(password.getBytes());
	             byte[] messageDigestMD5 = messageDigest.digest();
	             stringBuffer = new StringBuffer();
	             for (byte bytes : messageDigestMD5) {
	                 stringBuffer.append(String.format("%02x", bytes & 0xff));
	             }
	         } catch (NoSuchAlgorithmException exception) {
	             exception.printStackTrace();
	        }
	     
	    System.out.println(stringBuffer.toString());
	     boolean result = false;
		try {
			result = loginService.authenticateUser(userId, stringBuffer.toString(),st);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	    ResultSet user = null;
		try {
			user = (ResultSet) loginService.getUserByUserId(userId,st);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		try {
			while(user.next())
			{
				uid=Integer.parseInt(user.getString("uid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		
		try {
			st.close();
			ul.closeConnection();
			user.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	    if(result == true){
	        	
			request.getSession().setAttribute("user", uid);
			
	        RequestDispatcher rd = request.getRequestDispatcher("Welcome.jsp");
	 		rd.forward(request,response);
	    }
	    else{
	    	RequestDispatcher rd = request.getRequestDispatcher("LoginError.jsp");
	 		rd.forward(request,response);
	    }

	}

}
