package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.PreparedStatement;

import VO.User;

public class saveChangesDAO {
	
	public int update(User user,int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		int rowsAffected;
//		utilityClass ul = new utilityClass();
//		Statement st=ul.utility(con);
		PreparedStatement st = null;	
//		rowsAffected=st.executeUpdate("update user set fullname='"+user.getFullname()+"', day='"+user.getDay()+"', month='"+user.getMonth()+"', year='"+user.getYear()+"', livesin='"+user.getLivesin()+"', studiedat='"+user.getStudiedat()+"', bio='"+user.getBio()+"', status='"+user.getStatus()+"' where uid='"+userId+"'");
		String qry="update user set fullname=?, day=?, month=?, year=?, livesin=?, bio=?, status=? where uid=?";
		st=(PreparedStatement) con.prepareStatement(qry);
		
		st.setString(1,user.getFullname());
		st.setInt(2,user.getDay());
		st.setString(3,user.getMonth());
		st.setInt(4,user.getYear());
		st.setString(5,user.getLivesin());
		st.setString(6,user.getBio());
		st.setString(7,user.getStatus());
		st.setInt(8,userId);
		
		rowsAffected=st.executeUpdate();
		
		st.close();
		
		return rowsAffected;
	}

	public int updateWithProfile(User user, int uid, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		int rowsAffected;
//		utilityClass ul = new utilityClass();
//		Statement st=ul.utility(con);
		PreparedStatement st = null;
//		rowsAffected=st.executeUpdate("update user set fullname='"+user.getFullname()+"', day='"+user.getDay()+"', month='"+user.getMonth()+"', year='"+user.getYear()+"', livesin='"+user.getLivesin()+"', studiedat='"+user.getStudiedat()+"', bio='"+user.getBio()+"', status='"+user.getStatus()+"', profile_pic='"+user.getProfilePic()+"'  where uid='"+uid+"'");
		String qry="update user set fullname=?, day=?, month=?, year=?, livesin=?, bio=?, status=?, profile_pic=? where uid=?";
		st=(PreparedStatement) con.prepareStatement(qry);
		
		st.setString(1,user.getFullname());
		st.setInt(2,user.getDay());
		st.setString(3,user.getMonth());
		st.setInt(4,user.getYear());
		st.setString(5,user.getLivesin());
		st.setString(6,user.getBio());
		st.setString(7,user.getStatus());
		st.setString(8,user.getProfilePic());
		st.setInt(9,uid);
		
		rowsAffected=st.executeUpdate();
				
		st.close();
		
		return rowsAffected;
		
	}
	

}
