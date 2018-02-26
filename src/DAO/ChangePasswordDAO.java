package DAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class ChangePasswordDAO {
	
	public void updatePassword(int uid, String password ,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		st.executeUpdate("update user set password='"+password+"' where uid='"+uid+"'");
		st.close();
	}

}
