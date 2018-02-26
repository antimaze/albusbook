package servlet;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Profile
 */
@WebServlet("/Profile")
public class Profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Profile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Enumeration<String> en = request.getParameterNames();
		String searchId = null , action = null;
		while(en.hasMoreElements())
		{
			Object obj = en.nextElement();
			String parameter = (String)obj;
			
			if(parameter.equals("action"))
				action = request.getParameter(parameter);
			
			if(parameter.equals("searchId"))
				searchId = request.getParameter(parameter);
		}
		
		if(action == null)
			action = "profilebook";
		
		if(searchId == null)
			searchId = "1";
		
		RequestDispatcher rd ;
		HttpSession session = request.getSession(true);
		
		switch (action) {
		case "profilebook":
			
			session.setAttribute("searchId", searchId);
			
			rd = request.getRequestDispatcher("ShowProfileBook.jsp");
			rd.forward(request, response);
			
			break;
		
		case "messagebook":
			
			session.setAttribute("searchId", searchId);
			
			rd = request.getRequestDispatcher("ShowMessageBook.jsp");
			rd.forward(request, response);
			
			break;
			
		case "lifebook":
	
			session.setAttribute("searchId", searchId);
	
			rd = request.getRequestDispatcher("ShowLifeBook.jsp");
			rd.forward(request, response);
	
			break;

		case "messages":
			
			session.setAttribute("searchId", searchId);
	
			rd = request.getRequestDispatcher("ShowMessages.jsp");
			rd.forward(request, response);
	
			break;
			
		case "following":
			
			session.setAttribute("searchId", searchId);
	
			rd = request.getRequestDispatcher("ShowFollowing.jsp");
			rd.forward(request, response);
	
			break;
			
		case "followers":
			
			session.setAttribute("searchId", searchId);
	
			rd = request.getRequestDispatcher("ShowFollowers.jsp");
			rd.forward(request, response);
	
			break;
			
			
		default:
			break;
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
