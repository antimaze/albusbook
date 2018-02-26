package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import VO.likesForLifebook;

public class LikesForLifebook {

	public int insert(likesForLifebook llb, Connection con) throws ClassNotFoundException, SQLException {

		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected=st.executeUpdate("insert into likesforlifebook(uid,topic_id,lable) values('"+llb.getUid()+"','"+llb.getTopicid()+"','"+llb.getLable()+"')");
		st.close();
		
		return rowsAffected;
	}

	public ResultSet countLikes(int topicId, Connection con) throws ClassNotFoundException, SQLException {

		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=st.executeQuery("select count(*) total_likes from likesforlifebook where topic_id='"+topicId+"'");
		
		return rs;
	}

	public int deleteLikeEntry(int liker, int topicId, Connection con) throws ClassNotFoundException, SQLException {

		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		rowsAffected = st.executeUpdate("delete from likesforlifebook where uid='"+liker+"' and topic_id='"+topicId+"'");
		st.close();
		
		return rowsAffected;		
	}

	public void updateLikeCount(int topicId, int count, Connection con) throws ClassNotFoundException, SQLException {

		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		st.executeUpdate("update lifebook set likes='"+count+"' where tid='"+topicId+"'");
		st.close();
	}
}
