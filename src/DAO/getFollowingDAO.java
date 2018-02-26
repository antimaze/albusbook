package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class getFollowingDAO {
	
	public ResultSet getFollowing(int userId,int uid,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
/*		ResultSet rs=st.executeQuery("SELECT uid,fullname,messages,followers,profile_pic,followed,bio,o.lable"+
									 " FROM "+
									 " (`user` JOIN "+
											 " (SELECT uid AS userId,lable FROM follower WHERE follower_id='"+userId+"')AS o "+
													"  ON `user`.`uid`=o.userId)");
*/
		ResultSet rs=st.executeQuery("SELECT distinct p.uid,fullname,messages,followers,profile_pic,followed,bio,p.lable"+
				 " FROM "+
				 " `user` JOIN "+
						 "(SELECT * FROM "+
								"((SELECT distinct uid FROM follower WHERE follower_id='"+userId+"')AS o LEFT OUTER JOIN (SELECT distinct uid AS userId,lable FROM follower WHERE follower_id='"+uid+"')AS q ON o.uid=q.userId))AS p ON `user`.`uid`=p.uid ");
		
		return rs;
	}

}
