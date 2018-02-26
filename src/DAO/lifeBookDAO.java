package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.PreparedStatement;

import VO.lifeBook;

public class lifeBookDAO {
	
	public void insert(lifeBook lb,Connection con) throws ClassNotFoundException, SQLException 
	{
//		utilityClass ul = new utilityClass();
//		Statement st = (Statement)ul.utility(con);

		PreparedStatement st = null;
//		st.executeUpdate("insert into lifebook(uid,page1,page2,date,time,privacy) values('"+lb.getUid()+"','"+lb.getPage1()+"','"+lb.getPage2()+"','"+lb.getDate()+"','"+lb.getTime()+"','"+lb.getPrivacy()+"');");
		
		String qry="insert into lifebook(uid,page1,page2,date,time,privacy) values(?,?,?,?,?,?)";
		st=(PreparedStatement) con.prepareStatement(qry);

		st.setInt(1,lb.getUid());
		st.setString(2,lb.getPage1());
		st.setString(3,lb.getPage2());
		st.setString(4,lb.getDate());
		st.setString(5,lb.getTime());
		st.setInt(6,lb.getPrivacy());

		st.executeUpdate();
		st.close();
	}
	
}
