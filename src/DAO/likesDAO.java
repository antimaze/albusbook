package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import VO.likes;

public class likesDAO {

	public int insert(likes lk,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected=st.executeUpdate("insert into likes(uid,post_id,lable) values('"+lk.getUid()+"','"+lk.getPostId()+"','"+lk.getLable()+"')");
		st.close();
		
		return rowsAffected;
	}

	public ResultSet countLikes(int postId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=st.executeQuery("select count(*) total_likes from likes where post_id='"+postId+"'");
		
		return rs;
	}

	public void updateLikeCount(int postId, int count,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		st.executeUpdate("update followbook set likes='"+count+"' where pid='"+postId+"'");
		st.close();
		
	}

	public int deleteLikeEntry(int uid,int postId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		rowsAffected = st.executeUpdate("delete from likes where uid='"+uid+"' and post_id='"+postId+"'");
		st.close();
		
		return rowsAffected;
	}
}
