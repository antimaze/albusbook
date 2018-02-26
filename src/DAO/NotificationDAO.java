package DAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import VO.Notifications;

public class NotificationDAO {
	
	public int insert(Notifications no,Connection con) throws SQLException, ClassNotFoundException 
	{
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected=st.executeUpdate("insert into notifications(uid,followerid,flag,date) values('"+no.getUid()+"','"+no.getFollowerid()+"','"+no.getFlag()+"','"+no.getDate()+"')");
		st.close();
		return rowsAffected;
	}

	public int deleteEntry(int followed, int follower, Connection con) throws ClassNotFoundException, SQLException {
		
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from notifications where uid='"+followed+"' and followerid='"+follower+"'");
		st.close();
		return rowsAffected;
		
	}

	public int readMessage(int mid, int uid, Connection con) throws ClassNotFoundException, SQLException {
		
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("update notifications set flag='read' where mid='"+mid+"' and uid='"+uid+"'");
		st.close();
		return rowsAffected;
		
	}


}
