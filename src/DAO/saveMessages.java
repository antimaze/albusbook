package DAO;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.PreparedStatement;

import VO.Messages;

public class saveMessages {
	
	public int insert(Messages msg,Connection con) throws ClassNotFoundException, SQLException 
	{
		int rowsAffected;
//		utilityClass ul = new utilityClass();
//		Statement st = (Statement)ul.utility(con);
		PreparedStatement st = null;
		
		String qry="insert into messages(messagereciever,messagesender,message,date,time,flag) values(?,?,?,?,?,?)";
		st=(PreparedStatement) con.prepareStatement(qry);
		
//		rowsAffected=st.executeUpdate("insert into messages(messagereciever,messagesender,message,date,time,flag) values('"+msg.getMessageReciever()+"','"+msg.getMessageSender()+"','"+msg.getMessage()+"','"+msg.getDate()+"','"+msg.getTime()+"','"+msg.getFlag()+"');");
		
		st.setInt(1,msg.getMessageReciever());
		st.setInt(2,msg.getMessageSender());
		st.setString(3,msg.getMessage());
		st.setString(4,msg.getDate());
		st.setString(5,msg.getTime());
		st.setString(6,msg.getFlag());
		rowsAffected=st.executeUpdate();
		st.close();
		return rowsAffected;
	}
	
	public int readMessages(int mid, int uid, Connection con) throws ClassNotFoundException, SQLException {
		
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("update messages set flag='read' where messageid='"+mid+"' and messagereciever='"+uid+"'");
		st.close();
		return rowsAffected;
		
	}

}
