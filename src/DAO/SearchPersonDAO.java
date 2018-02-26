package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SearchPersonDAO {
	
	public ResultSet getSearchUser(String userName,int uid,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		String username = userName.replaceAll("'", "");
		ResultSet rs = st.executeQuery("select q.*,lable from " +
				"((select uid,fullname,username,messages,followers,profile_pic,followed,bio from user where uid like '%"+username+"%')" +
				"union" +
				"(select uid,fullname,username,messages,followers,profile_pic,followed,bio from user where fullname like '%"+username+"%' or username like '%"+username+"%'))as q " +
				"left outer join " +
				"(select * from follower where follower_id='"+uid+"')as o " +
				"on q.uid=o.uid ");
		return rs;
	}

}
