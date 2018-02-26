package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class getFollowersDAO {
	
	public ResultSet getFollowers(int userId,int uid,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=st.executeQuery("SELECT distinct p.follower_id,fullname,messages,followers,profile_pic,followed,bio,p.lable"+
									 " FROM "+
									 " (`user` JOIN "+
											 " (SELECT * FROM "+
													 " ((SELECT distinct follower_id FROM follower WHERE uid='"+userId+"')AS o LEFT OUTER JOIN (SELECT distinct uid AS userId,lable FROM follower WHERE follower_id='"+uid+"')AS q ON o.follower_id=q.userId))AS p "+ 
													"  ON `user`.`uid`=p.follower_id)");
		
		return rs;
	}

}
