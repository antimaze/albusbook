package servlet;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchPerson
 */
@WebServlet("/SearchPerson")
public class SearchPerson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchPerson() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		Enumeration<String> en = request.getParameterNames();
		String searchname = null;
		while(en.hasMoreElements())
		{
			Object obj = en.nextElement();
			String parameter = (String)obj;
			
			if(parameter.equals("s"))
				searchname = request.getParameter(parameter);
		}
		
		if(searchname == null)
			searchname = "1" ;
		
		request.setAttribute("searchname", searchname);
		
		RequestDispatcher rd = request.getRequestDispatcher("SearchPerson.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
	}

}
