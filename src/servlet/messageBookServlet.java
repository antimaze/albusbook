package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

import DAO.SearchDAO;
import DAO.followBookDAO;
import DAO.utilityClass;
import VO.followBook;

/**
 * Servlet implementation class opinionBookServlet
 */
@WebServlet("/messageBookServlet")
public class messageBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public messageBookServlet() {
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
			RequestDispatcher rd = request.getRequestDispatcher("MessageBook.jsp");
			rd.forward(request,response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("My prediction was right...");
		PrintWriter o = response.getWriter();
		
		Connection con=null;
		utilityClass ul = new utilityClass();
		
		try {
			con=ul.getConnection();
		} catch (ClassNotFoundException | SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		int count=0;
		String page1 = request.getParameter("text1");
		String page2 = request.getParameter("text2");
		HttpSession session = request.getSession(true);
		Integer userId = Integer.parseInt(session.getAttribute("user").toString());
		int uid = userId.intValue();
		int result=0;
		
		DateFormat dateFormat = new SimpleDateFormat("dd/MMM/yyyy");
		DateFormat timeFormat = new SimpleDateFormat("h:mm aa");

		Calendar cal = Calendar.getInstance();
		Calendar cal1 = Calendar.getInstance();

		String date=(String)dateFormat.format(cal.getTime());
		String time=(String)timeFormat.format(cal1.getTime());
		
		followBook fb = new followBook();
		fb.setUid(uid);
		fb.setPage1(page1);
		fb.setPage2(page2);
		fb.setDate(date);
		fb.setTime(time);
		
		followBookDAO fbd = new followBookDAO();
		try {
			result=fbd.insert(fb,con);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		ResultSet messageCount = null;
		
		if(result>0)
		{
			
			try {
				messageCount=fbd.countMessages(uid,con);
				
				while(messageCount.next())
				{
					count = Integer.parseInt(messageCount.getString("total_messages").toString());
				}
				
				fbd.updateMessageCount(uid, count,con);
				messageCount.close();
				ul.closeConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

}
