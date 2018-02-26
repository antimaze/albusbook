package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class loginDAO {
	
public boolean authenticateUser(String userId, String password,Statement st) throws SQLException, ClassNotFoundException {
    	
        ResultSet user = getUserByUserId(userId,st);       
        
        while(user.next())
        {
        if(user.getString("username").equals(userId) && user.getString("password").equals(password)){
            return true;
        }else{
            return false;
        }
        }
		return false;
    }

public ResultSet getUserByUserId(String userId,Statement st) throws ClassNotFoundException, SQLException {
	// TODO Auto-generated method stub
		
	ResultSet rs = st.executeQuery("select * from user where username='"+userId+"'");	
	
	return rs;
}

}
