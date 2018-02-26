package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.ChangePasswordDAO;
import DAO.SearchDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordServlet() {
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
		
		String password= request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassowrd = request.getParameter("confirmPassword");
		HttpSession session = request.getSession(true);
		Integer uid = Integer.parseInt(session.getAttribute("user").toString());
		int userId = uid.intValue();
		
		System.out.println(password);
		System.out.println(newPassword);
		System.out.println(confirmPassowrd);
		System.out.println(userId);
		
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
         boolean flag = false;
        try {
			flag= sd.CheckUserPassword(userId,stringBuffer.toString(),con);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
        if(flag == true)
        {
        	if(!newPassword.trim().equals("") && !confirmPassowrd.trim().equals(""))
        	{
        		if(newPassword.equals(confirmPassowrd))
        		{
        			StringBuffer stringBuffer1 = null;
        			try {
        	             messageDigest = MessageDigest.getInstance("MD5");
        	             messageDigest.update(newPassword.getBytes());
        	             byte[] messageDigestMD5 = messageDigest.digest();
        	             stringBuffer1 = new StringBuffer();
        	             for (byte bytes : messageDigestMD5) {
        	                 stringBuffer1.append(String.format("%02x", bytes & 0xff));
        	             }
        	         } catch (NoSuchAlgorithmException exception) {
        	             exception.printStackTrace();
        	        }
        			
        			ChangePasswordDAO cpd = new ChangePasswordDAO();
        			try {
						cpd.updatePassword(userId, stringBuffer1.toString(), con);
						RequestDispatcher rd = request.getRequestDispatcher("PasswordChanged.jsp");
				 		rd.forward(request,response);
					} catch (ClassNotFoundException | SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
        		}
        	}
        }
        else
        {
        	RequestDispatcher rd = request.getRequestDispatcher("PasswordChanged1.jsp");
	 		rd.forward(request,response);
        }
		
	}

}
