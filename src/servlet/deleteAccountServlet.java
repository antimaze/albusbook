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

import DAO.DeleteAccountDAO;
import DAO.SearchDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class deleteAccountServlet
 */
@WebServlet("/deleteAccountServlet")
public class deleteAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteAccountServlet() {
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
			RequestDispatcher rd = request.getRequestDispatcher("Index.jsp");
			rd.forward(request,response);
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
		
		HttpSession session = request.getSession(true);
		Integer uid = Integer.parseInt(session.getAttribute("user").toString());
		int userId = uid.intValue();
		
		String email = request.getParameter("emailindeleteaccount");
		String password = request.getParameter("passwordindeleteaccount");
		
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
		
		
		if(email != null && password != null)
		{
			SearchDAO sd = new SearchDAO();
			try {
				boolean flag = sd.checkEmailPasswordForDeleteAccount(userId,email,stringBuffer.toString(),con);
				
				if(flag)
				{
					
					DeleteAccountDAO dao = new DeleteAccountDAO();
					dao.deleteFollowbook(userId, con);
					dao.deleteLifebook(userId, con);
					dao.deleteLikes(userId, con);
					dao.deleteLikesforlifebook(userId, con);
					dao.deleteFollower(userId, con);
					dao.deleteMessages(userId, con);
					dao.deletenotification(userId, con);
					dao.deleteUser(userId, con);
					
					request.getSession().invalidate();
					RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
			 		rd.forward(request,response);
				}
				else
				{
					RequestDispatcher rd = request.getRequestDispatcher("AccountDeletionFailed.jsp");
			 		rd.forward(request,response);
				}
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else
		{
			
		}
		
		
	}

}
