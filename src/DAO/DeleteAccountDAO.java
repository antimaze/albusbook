package DAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class DeleteAccountDAO {
	
	public int deleteFollowbook(int uid,Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from followbook where uid='"+uid+"'");
		st.close();
		return rowsAffected;
	}
	
	public int deleteFollower(int uid,Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from follower where uid='"+uid+"' or follower_id='"+uid+"'");
		st.close();
		return rowsAffected;
	}
	
	public int deleteLifebook(int uid,Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from lifebook where uid='"+uid+"'");
		st.close();
		return rowsAffected;
	}
	
	
	public int deleteLikes(int uid, Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from likes where uid='"+uid+"'");
		st.close();
		return rowsAffected;
	}
	
	public int deleteLikesforlifebook(int uid, Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from likesforlifebook where uid='"+uid+"'");
		st.close();
		return rowsAffected;
	}
	
	public int deletenotification(int uid,Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from notifications where uid='"+uid+"' or followerid='"+uid+"'");
		st.close();
		return rowsAffected;
	}
	
	public int deleteMessages(int uid,Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from messages where messagereciever='"+uid+"' or messagesender='"+uid+"'");
		st.close();
		return rowsAffected;
	}
	
	public int deleteUser(int uid,Connection con) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from user where uid='"+uid+"'");
		st.close();
		return rowsAffected;
	}

}
