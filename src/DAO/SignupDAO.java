package DAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import VO.User;

public class SignupDAO {

	public int insert(User user, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		int rowsAffected=0;
		utilityClass ul = new utilityClass();
		Statement st = (Statement)ul.utility(con);
		
		rowsAffected= st.executeUpdate("insert into user(fullname,day,month,year,gender,username,password,profile_pic,date,time) values('"+user.getFullname().replace("'","''")+"','"+user.getDay()+"','"+user.getMonth()+"','"+user.getYear()+"','"+user.getGender()+"','"+user.getUsername()+"','"+user.getPassword()+"','"+user.getProfilePic()+"','"+user.getDate()+"','"+user.getTime()+"'); ");
		
		st.close();
		return rowsAffected;
		
	}

}
