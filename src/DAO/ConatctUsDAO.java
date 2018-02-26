package DAO;

import java.sql.Connection;
import java.sql.SQLException;

import VO.ConatactUs;

import com.mysql.jdbc.PreparedStatement;

public class ConatctUsDAO {
	
	public void insert(ConatactUs cud, Connection con) throws ClassNotFoundException, SQLException 
	{
		PreparedStatement st = null;
		
		String qry="insert into contactus(fullname,email,subject,message) values(?,?,?,?)";
		st=(PreparedStatement) con.prepareStatement(qry);

		st.setString(1,cud.getFullname());
		st.setString(2,cud.getEmail());
		st.setString(3,cud.getSubject());
		st.setString(4,cud.getMesssage());

		st.executeUpdate();
		st.close();
	}
}
