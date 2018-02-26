package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import antlr.StringUtils;

import DAO.SearchDAO;
import DAO.saveChangesDAO;
import DAO.utilityClass;
import VO.User;

/**
 * Servlet implementation class saveChanges
 */
@WebServlet("/saveChanges")
public class saveChanges extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final int THRESHOLD_SIZE 	= 1024 * 1024 * 3; 	// 3MB
	private static final int MAX_FILE_SIZE 		= 1024 * 1024 * 40; // 40MB
	private static final int MAX_REQUEST_SIZE 	= 1024 * 1024 * 50; // 50MB
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public saveChanges() {
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
		
		PrintWriter o = response.getWriter();
		
		utilityClass ul = new utilityClass();
		Connection con=null;
		try {
			con = ul.getConnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String[] name = new String[11];
		HttpSession session = request.getSession(true);
		Integer uid = Integer.parseInt(session.getAttribute("user").toString());
		int userId = uid.intValue();
		String profilepic=null;
		int counter=0;
		String filePath=null;
		String fullname=null;
		int day=0;
		String month=null;
		int year=0;
		String bio=null;
		String livesin=null;
		String status=null;
		String fileName= null;
		
		if (!ServletFileUpload.isMultipartContent(request)) {
			PrintWriter writer = response.getWriter();
			writer.println("Request does not contain upload data");
			writer.flush();
			return;
		}
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(THRESHOLD_SIZE);
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setFileSizeMax(MAX_FILE_SIZE);
		upload.setSizeMax(MAX_REQUEST_SIZE);
		
		String uploadPath = "C://Users/savan/workspace1/DesigningAndCodingOfSamino/WebContent/uploadedImages";
		
		// creates the directory if it does not exist
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}
		

		System.out.println(upload.getFileItemFactory().toString());
		
		try {
			// parses the request's content to extract file data
			//System.out.println(request);
			List formItems = upload.parseRequest(request);

			Iterator iter = formItems.iterator();
			// iterates over form's fields
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				// processes only fields that are not form fields
				if (!item.isFormField()) 
				{
					fileName = new File(item.getName()).getName();
					profilepic=(String)fileName;
					
					if(!fileName.isEmpty())
					{
					filePath = uploadPath + File.separator + fileName;
					File storeFile = new File(filePath);
					
					// saves the file on disk
					item.write(storeFile);
					}
				}
				else
				{
					name[counter]=item.getString();										
				}
				counter++;
			}
			
/*			for(int i=0;i<counter;i++)
				System.out.println(i+"	"+name[i]);
*/						

			fullname=name[2];
			day=Integer.parseInt(name[3]);
			month=name[4];
			year=Integer.parseInt(name[5]);
			livesin=name[6];
			bio=name[7];
			status=name[8];
			
						
			
			User user = new User();
			user.setFullname(fullname);
			user.setBio(bio);
			user.setDay(day);
			user.setLivesin(livesin);
			user.setMonth(month);
			user.setYear(year);
			user.setStatus(status);
						
			saveChangesDAO scd = new saveChangesDAO();
			if(fileName.isEmpty())
			{
				System.out.println("Without Profile");
				scd.update(user, userId, con);
			}
			else
			{
				user.setProfilePic(profilepic);
				scd.updateWithProfile(user, userId, con);
			}
		
/*			o.print(name[2]);
			o.print(";");
			o.print(name[3]);
			o.print(";");
			o.print(name[4]);
			o.print(";");
			o.print(name[5]);
			o.print(";");
			o.print(name[6]);
			o.print(";");
			o.print(name[7]);
			o.print(";");
			o.print(name[8]);
*/
			con.close();
			ul.closeConnection();
			
			RequestDispatcher rd = request.getRequestDispatcher("ShowProfileBook.jsp?searchId="+userId);
			rd.forward(request, response);
			
		}
		catch (Exception e) 
		{
			System.out.println("File upload failed");
			System.out.println(e);
        }		
		
//		RequestDispatcher rd = request.getRequestDispatcher("ShowProfileBook.jsp?searchId="+uid);
// 		rd.forward(request,response);
		
	}

}
