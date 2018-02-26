package servlet;

import java.io.IOException;
import java.sql.Connection;
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

import DAO.lifeBookDAO;
import DAO.utilityClass;
import VO.lifeBook;

/**
 * Servlet implementation class lifeBookServlet
 */
@WebServlet("/lifeBookServlet")
public class lifeBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public lifeBookServlet() {
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
		
		utilityClass ul = new utilityClass();
		Connection con = null;
		try {
			con=ul.getConnection();
		} catch (ClassNotFoundException | SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		int privacyValue=0;
		String page1 = request.getParameter("text1");
		String page2 = request.getParameter("text2");
		String privacy = request.getParameter("privacy");
		HttpSession session = request.getSession(true);
		Integer userId = Integer.parseInt(session.getAttribute("user").toString());
		int uid = userId.intValue();
		
		if(privacy.equals("private"))
			privacyValue=1;
		
		DateFormat dateFormat = new SimpleDateFormat("dd/MMM/yyyy");
		DateFormat timeFormat = new SimpleDateFormat("hh:mm aa");

		Calendar cal = Calendar.getInstance();
		Calendar cal1 = Calendar.getInstance();

		String date=(String)dateFormat.format(cal.getTime());
		String time=(String)timeFormat.format(cal1.getTime());
		
		
		lifeBook lb = new lifeBook();
		lb.setUid(uid);
		lb.setDate(date);
		lb.setTime(time);
		lb.setPage1(page1);
		lb.setPage2(page2);
		lb.setPrivacy(privacyValue);
		
		lifeBookDAO lbd = new lifeBookDAO();
		try {
			lbd.insert(lb,con);
			ul.closeConnection();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
