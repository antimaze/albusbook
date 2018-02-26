package DAO;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.PreparedStatement;

import VO.followBook;

public class followBookDAO {
	
	public int insert(followBook fb,Connection con) throws ClassNotFoundException, SQLException 
	{
		int rowsAffected;
//		utilityClass ul = new utilityClass();
//		Statement st = (Statement)ul.utility(con);
		PreparedStatement st = null;
		
		String qry="insert into followbook(uid,page1,page2,date,time) values(?,?,?,?,?)";
		st=(PreparedStatement) con.prepareStatement(qry);

		st.setInt(1,fb.getUid());
		st.setString(2,fb.getPage1());
		st.setString(3,fb.getPage2());
		st.setString(4,fb.getDate());
		st.setString(5,fb.getTime());
		
//		rowsAffected=st.executeUpdate("insert into followbook(uid,page1,page2,date,time) values('"+fb.getUid()+"','"+fb.getPage1()+"','"+fb.getPage2()+"','"+fb.getDate()+"','"+fb.getTime()+"');");
		rowsAffected=st.executeUpdate();
		
		st.close();
		return rowsAffected;
	}
	
	public ResultSet countMessages(int uid,Connection con) throws ClassNotFoundException, SQLException
	{		
		utilityClass ul = new utilityClass();
		Statement st = (Statement)ul.utility(con);
		
		ResultSet rs=st.executeQuery("select count(*) total_messages from followbook where uid='"+uid+"'");
		return rs;
	}

	public void updateMessageCount(int userId, int count,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		st.executeUpdate("update user set messages='"+count+"' where uid='"+userId+"'");
		st.close();
	}

}
