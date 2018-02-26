package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import VO.follow;

public class followDAO {
	public int insert(follow f,Connection con) throws SQLException, ClassNotFoundException 
	{
		int rowsAffected = 0;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs=st.executeQuery("select * from follower where follower_id='"+f.getFollower()+"' and uid='"+f.getFollowed()+"'");
		
		if(!rs.next())
			rowsAffected=st.executeUpdate("insert into follower(uid,follower_id,lable) values('"+f.getFollowed()+"','"+f.getFollower()+"','"+f.getLable()+"')");
		
		st.close();
		return rowsAffected;
	}

	public int deleteFollowEntry(int followed, int follower,Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from follower where uid='"+followed+"' and follower_id='"+follower+"'");
		st.close();
		return rowsAffected;
	}

	public void updateFollowedCount(int follower, int followedCount,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		st.executeUpdate("update user set followed='"+followedCount+"' where uid='"+follower+"'");
		st.close();
	}

	public ResultSet countFollowed(int follower,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=st.executeQuery("select count(*) total_count from follower where follower_id='"+follower+"'");
		
		return rs;
	}
	
	public ResultSet countFollower(int followed,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=st.executeQuery("select count(*) total_count from follower where uid='"+followed+"'");
		
		return rs;
	}

	public void updateFollowerCount(int followed, int followerCount,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		st.executeUpdate("update user set followers='"+followerCount+"' where uid='"+followed+"'");
		st.close();
	}
}
