package DAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class ChangeEmailDAO {
	public void updateEmail(int uid, String email ,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		st.executeUpdate("update user set username='"+email+"' where uid='"+uid+"'");
		st.close();
	}

}
