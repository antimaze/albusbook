package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.Security;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import DAO.ChangePasswordDAO;
import DAO.SearchDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class ForgetPassword
 */
@WebServlet("/ForgetPassword")
public class ForgetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgetPassword() {
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
			RequestDispatcher rd = request.getRequestDispatcher("ForgetPassword.jsp");
			rd.forward(request,response);
		}
		else
		{
			RequestDispatcher rd = request.getRequestDispatcher("ForgetPassword.jsp");
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
		
		String uid = request.getParameter("userId");
		int userId=0;
		if(!uid.equals(""))
		{
			userId = Integer.parseInt(uid);
		}
		String email = request.getParameter("email");
		
		if(!uid.equals("") && !email.equals(""))
		{
			SearchDAO sd = new SearchDAO();
			try {
				boolean flag = sd.checkEmail(email, userId, con);
				
				if(flag)
				{
					
					String password = sd.getPassword(userId, con);
					
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
			         
			         ChangePasswordDAO cpd = new ChangePasswordDAO();
	        			try {
							cpd.updatePassword(userId, stringBuffer.toString(), con);
						} catch (ClassNotFoundException | SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					
					Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
					  
					Properties props = new Properties();
					props.setProperty("mail.transport.protocol", "smtp");
					  
					props.setProperty("mail.host", "smtp.gmail.com");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", "465");
					props.put("mail.debug", "true");
					props.put("mail.smtp.socketFactory.port", "465");
					props.put("mail.smtp.socketFactory.class",
					"javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.socketFactory.fallback", "false");
					props.setProperty("mail.smtp.quitwait", "false");
					 
					Session session = Session.getDefaultInstance(props,
					new javax.mail.Authenticator() {
					  
					protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("albusbook750@gmail.com","albusbook7508401300410sp@!");
					}
					});
					  
					session.setDebug(true);
					  
					 
					Transport transport = session.getTransport();
					InternetAddress addressFrom = new InternetAddress("savanpatel750@gmail.com");
					  
					MimeMessage message = new MimeMessage(session);
					message.setSender(addressFrom);
					message.setSubject("Albusbook Password Changed Message");
					message.setContent("This is your new password for Albusbook account : "+password, "text/plain");
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
					  
					transport.connect();
					transport.send(message);
					transport.close();
					
					RequestDispatcher rd = request.getRequestDispatcher("Index.jsp");
			 		rd.forward(request,response);
				}
				
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (NoSuchProviderException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

}
