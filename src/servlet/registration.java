package servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import VO.User;

import DAO.SearchDAO;
import DAO.SignupDAO;
import DAO.utilityClass;

/**
 * Servlet implementation class registration
 */
@WebServlet("/registration")
public class registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registration() {
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
			RequestDispatcher rd = request.getRequestDispatcher("Index.jsp");
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
		try {
			con = ul.getConnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String fullname= request.getParameter("fullname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String cpassword = request.getParameter("cpass");
		int day = Integer.parseInt(request.getParameter("day"));
		String month = request.getParameter("month");
		int year = Integer.parseInt(request.getParameter("year"));
		String sex= request.getParameter("sex");
		boolean flag=false;
		
		System.out.println(fullname);
		System.out.println(email);
		System.out.println(password);
		System.out.println(cpassword);
		System.out.println(day);
		System.out.println(month);
		System.out.println(year);
		System.out.println(sex);
		
		String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";
		Boolean b = email.matches(EMAIL_REGEX);
		
		SearchDAO sd = new SearchDAO();
		try {
			flag = sd.checkUsernameAvailability(email,con);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		if((fullname.length()<=20) && b && flag && (password.equals(cpassword)))
		{
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
	         
	        DateFormat dateFormat = new SimpleDateFormat("dd/MMM/yyyy");
	 		DateFormat timeFormat = new SimpleDateFormat("h:mm aa");

	 		Calendar cal = Calendar.getInstance();
	 		Calendar cal1 = Calendar.getInstance();

	 		String date=(String)dateFormat.format(cal.getTime());
	 		String time=(String)timeFormat.format(cal1.getTime());
	 		
			User user = new User();
			user.setFullname(fullname);
			user.setUsername(email);
			user.setPassword(stringBuffer.toString());
			user.setDay(day);
			user.setMonth(month);
			user.setYear(year);
			user.setGender(sex);
			user.setProfilePic("default.png");
			user.setDate(date);
			user.setTime(time);
			
			int rowsAffected=0;
			SignupDAO sud = new SignupDAO();
			try {
				rowsAffected = sud.insert(user,con);
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			System.out.println("Yes,,,i can now enter values in database...");
			
			if(rowsAffected>0)
			{
				try {
					ResultSet rs = (ResultSet) sd.getUserByUsername(email,con);
					int userId;
					while(rs.next())
					{
						userId = Integer.parseInt(rs.getString("uid"));
						request.getSession().setAttribute("user", userId);
						
						RequestDispatcher rd = request.getRequestDispatcher("Index.jsp");
				 		rd.forward(request,response);
					}
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		else
		{
			System.out.println("No,,,You cant insert values in database...");
		}
		
	}

}
