package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.PreparedStatement;

public class SearchDAO {
	
	public ResultSet getUserByUserId(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select * from user where uid='"+userId+"'");
		return rs;
	}

	public ResultSet getWhoToFollow(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select distinct o.uid,fullname,followers,profile_pic,messages,followed,bio from user u join " +
				"(select distinct s.uid from (select uid from follower where follower_id in " +
				"(select distinct uid from follower where follower_id='"+userId+"'))as s where s.uid not in (select distinct uid from follower where follower_id='"+userId+"') and s.uid<>'"+userId+"')as o on u.uid=o.uid order by rand() limit 2");
	
		return rs;
	}
	
	public ResultSet getAllWhoToFollow(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select distinct o.uid,fullname,followers,profile_pic,messages,followed,bio from user u join " +
				"(select s.uid from (select uid from follower where follower_id in " +
				"(select uid from follower where follower_id='"+userId+"'))as s where s.uid not in (select uid from follower where follower_id='"+userId+"') and s.uid<>'"+userId+"')as o on u.uid=o.uid order by rand()");
	
		return rs;
	}
	
	public ResultSet getMyMessages(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("SELECT o.*,user.fullname,user.profile_pic FROM((select * from followbook where uid='"+userId+"')as o join user on user.uid=o.uid) order by pid desc");
		
		return rs;
	}
	
	public ResultSet getMyLife(int searchId,int uid,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
//		ResultSet rs = st.executeQuery("select o.*,user.fullname,user.profile_pic from(( select * from lifebook where uid='"+userId+"' order by tid desc)as o join user on user.uid=o.uid)");
		ResultSet rs = st.executeQuery("select distinct q.*,lable from (select o.*,fullname,profile_pic from ((select tid,uid as userId,page1,page2,date,time,privacy,likes from lifebook where uid='"+searchId+"' and privacy='0' order by tid desc) as o join user on user.uid=o.userId))as q left outer join (select topic_id as tid,lable from likesforlifebook where uid='"+uid+"')as p on q.tid=p.tid ORDER BY tid DESC");
		
		return rs;
	}
	
	public ResultSet getMyWholeLife(int searchId,int uid,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
//		ResultSet rs = st.executeQuery("select o.*,user.fullname,user.profile_pic from(( select * from lifebook where uid='"+userId+"' order by tid desc)as o join user on user.uid=o.uid)");
		ResultSet rs = st.executeQuery("select distinct q.*,lable from (select o.*,fullname,profile_pic from ((select tid,uid as userId,page1,page2,date,time,privacy,likes from lifebook where uid='"+searchId+"' order by tid desc) as o join user on user.uid=o.userId))as q left outer join (select topic_id as tid,lable from likesforlifebook where uid='"+uid+"')as p on q.tid=p.tid ORDER BY tid DESC");
		
		return rs;
	}
	
	public ResultSet getPublicLifeOfUser(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select * from lifebook where uid='"+userId+"' and privacy=0 order by tid desc");
		
		return rs;
	}

	public ResultSet getUsers(String username,int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		System.out.println(con.toString());
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		return st.executeQuery("select distinct * from (select * from user where user.firstname='"+username+"')as q left outer join follower on follower.follower_id='"+userId+"' and q.uid=follower.uid");
		
	}
	
	public ResultSet getUsersWithLastname(String[] username,int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		System.out.println(con.toString());

		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		return st.executeQuery("select distinct * from ((select * from user where user.firstname='"+username[0]+"' and user.lastname='"+username[1]+"') " +
				"union (select * from user where user.firstname='"+username[1]+"' and user.lastname='"+username[0]+"') )as q left outer join follower on follower.follower_id='"+userId+"' and q.uid=follower.uid");
		
	}
	
	public ResultSet getUser(int userId,int uid,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		System.out.println(con.toString());

		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		return st.executeQuery("select distinct * from (select * from user where user.uid='"+userId+"')as q left outer join follower on follower.follower_id='"+uid+"' and q.uid=follower.uid");
		
		
	}
	
	public ResultSet getNewsFeed(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select distinct q.pid,q.uid,q.page1,q.page2,q.date,q.time,q.fullname,q.profile_pic,likes.lable from" +
				"(select o.pid,o.uid,o.page1,o.page2,o.date,o.time,user.fullname,user.profile_pic from " +
				"((select pid,followbook.uid,page1,page2,date,time from followbook join follower on followbook.uid=follower.uid where follower.follower_id='"+userId+"')" +
						"union (select pid,followbook.uid,page1,page2,date,time from followbook join follower on followbook.uid=follower.uid where follower.uid='"+userId+"')" +
								"UNION (SELECT pid,followbook.uid,page1,page2,DATE,TIME FROM followbook WHERE followbook.uid='"+userId+"') )" +
						"as o join user on o.uid=user.uid)as q left outer join likes on q.pid=likes.post_id and likes.uid='"+userId+"' ORDER BY q.pid desc");
		
		return rs;
	}

	public int deleteMessageByPostId(int postId,int userId, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		int rowsAffected=st.executeUpdate("delete from followbook where pid='"+postId+"' and uid='"+userId+"'");
		
		st.close();
		return rowsAffected;
	}
	
	public int deleteLifeMessageByPostId(int postId,int userId, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		int rowsAffected=st.executeUpdate("delete from lifebook where tid='"+postId+"' and uid='"+userId+"'");
		
		st.close();
		return rowsAffected;
	}

	public ResultSet getWhoToFollowByRefresh(int userId, int limit,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select distinct * from user u join " +
				"(select s.uid from (select uid from follower where follower_id in " +
				"(select uid from follower where follower_id='"+userId+"'))as s where s.uid not in (select uid from follower where follower_id='"+userId+"') and s.uid<>'"+userId+"')as o on u.uid=o.uid order limit "+limit+",4");
	
		return rs;
	}

	public boolean getNotifications(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		boolean flag=false;
		
		ResultSet rs=(ResultSet) st.executeQuery("select distinct * from notifications where uid='"+userId+"' and flag='unread'");
		if(!rs.next())
			flag=false;
		else
			flag=true;
		
		return flag;
	}
	
	public ResultSet getNotificationsForJsp(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select distinct user.uid,user.fullname,user.profile_pic,o.date,o.mid from" +
				"(select * from notifications where uid='"+userId+"' and flag='unread')as o join user on o.followerid=user.uid ORDER BY mid DESC");
		
		return rs;
	}
	
	public ResultSet getNotificationsForJsp1(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select distinct user.uid,user.fullname,user.profile_pic,o.date,o.mid from" +
				"(select * from notifications where uid='"+userId+"' and flag='read')as o join user on o.followerid=user.uid ORDER BY mid DESC");
		
		return rs;
	}
	
	public boolean getMessagesFlag(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		boolean flag=false;
		
		ResultSet rs=(ResultSet) st.executeQuery("select distinct * from messages where messagereciever='"+userId+"' and flag='unread'");
		if(!rs.next())
			flag=false;
		else
			flag=true;
		
		return flag;
	}
	
	public ResultSet getRecievedMessages(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("SELECT o.*,user.`fullname` FROM (select distinct * from messages where messagereciever='"+userId+"')AS o JOIN USER ON o.messagesender=user.`uid` ORDER BY messageid DESC limit 100");
		
		return rs;
	}
	
	public ResultSet getSendedMessages(int userId,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("SELECT o.*,user.`fullname` FROM (SELECT DISTINCT * FROM messages WHERE messagesender='"+userId+"')AS o JOIN USER ON o.messagereciever=user.`uid` ORDER BY messageid DESC LIMIT 100");
		
		return rs;
	}

	public boolean checkUsernameAvailability(String email, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		boolean flag = false;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select * from user where username='"+email+"'");
		
		if(!rs.next())
			flag=true;
		else
			flag=false;
		
		return flag;
	}

	public ResultSet getUserByUsername(String email, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select * from user where username='"+email+"'");
		
		return rs;
	}

	public boolean CheckUserPassword(int userId, String string, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		boolean flag = false;
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select * from user where uid='"+userId+"' and password='"+string+"'");
		
		if(!rs.next())
		{
			flag=false;
		}
		else
		{
			flag=true;
		}
		
		return flag;
	}
	
	public boolean CheckUserID(int userId, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		boolean flag = false;
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select * from user where uid='"+userId+"'");
		
		if(!rs.next())
		{
			flag=false;
		}
		else
		{
			flag=true;
		}
		
		return flag;
	}

	public boolean checkEmail(String email, int userId, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		boolean flag=false;
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select * from user where uid='"+userId+"' and username='"+email+"'");
		
		if(!rs.next())
		{
			flag=false;
		}
		else
		{
			flag=true;
		}
		
		return flag;
	}

	public boolean checkEmailWithSystem(String newEmail, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		boolean flag=false;
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs=(ResultSet) st.executeQuery("select * from user where username='"+newEmail+"'");
		
		if(rs.next())
		{
			flag=false;
		}
		else
		{
			flag=true;
		}
		
		return flag;
	}
	
	public ResultSet getLikersName(int pid, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		ResultSet rs=(ResultSet) st.executeQuery("select user.uid,fullname,profile_pic from (select * from likes where post_id='"+pid+"')as o join user on o.uid=user.uid LIMIT 25");
		
		return rs;
	}

	public ResultSet getLikersNameForLifeBook(int tid, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		ResultSet rs=(ResultSet) st.executeQuery("select user.uid,fullname,profile_pic from (select * from likesforlifebook where topic_id='"+tid+"')as o join user on o.uid=user.uid LIMIT 25");
		
		return rs;
	}

	public String getPassword(int userId, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		ResultSet rs=(ResultSet) st.executeQuery("select password from user where uid='"+userId+"'");
		
		String password=null;
		
		while(rs.next())
		{
			password = rs.getString("password");
		}
		
		return password;
	}
	
	public ResultSet getNumberOfUsers(Connection con, String password) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		ResultSet rs= null;
		if(password.equals("saminocompanyfuture8401300410sp"))
		{
			rs=(ResultSet) st.executeQuery("select count(*) as totalusers from user ");
		}
		return rs;
	}
	
	public ResultSet getAdminMessages(Connection con, String password) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		ResultSet rs= null;
		if(password.equals("saminocompanyfuture8401300410sp"))
		{
			rs=(ResultSet) st.executeQuery("SELECT * FROM contactus ORDER BY id DESC");
		}
		return rs;
	}
	
	public ResultSet getUsersWhoFollowedMe(int userId,int uid,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select distinct fullname,uid from (user join (select follower_id from follower where uid='"+uid+"')as q on user.uid=q.follower_id) where uid='"+userId+"'");
		return rs;
	}

	public int deleteadminmessage(String messageid, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		int rowsAffected;
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		rowsAffected = st.executeUpdate("delete from contactus where id='"+messageid+"'");
		st.close();
		return rowsAffected;
		
	}

	public boolean checkEmailPasswordForDeleteAccount(int userId, String email,
			String password, Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		
		ResultSet rs = st.executeQuery("select * from user where uid='"+userId+"' and username='"+email+"' and password='"+password+"'");
		
		if(!rs.next())
		{
			st.close();
			return false;
		}
		else
		{
			st.close();
			return true;
		}
	}
	
	public boolean isFollow(int userId,int userID,Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
		boolean flag=false;
		
		ResultSet rs=(ResultSet) st.executeQuery("select distinct * from follower where uid='"+userID+"' and follower_id='"+userId+"'");
		if(!rs.next())
			flag=false;
		else
			flag=true;
		
		return flag;
	}

	public void quoteOfTheDay(String quote,String uid, Connection con) throws SQLException {
		// TODO Auto-generated method stub
		
		
		if(uid.equals("saminocompanyfuture8401300410sp"))
		{
		PreparedStatement st = null;
		
		String qry="insert into quoteoftheday(quote) values(?)";
		st=(PreparedStatement) con.prepareStatement(qry);

		st.setString(1,quote);
		
		st.executeUpdate();
		st.close();
		}
	}
	
	public ResultSet getQuoteOfTheDay(Connection con) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		
		utilityClass ul = new utilityClass();
		Statement st=ul.utility(con);
			
		ResultSet rs = st.executeQuery("select * from quoteoftheday order by id desc limit 1");
		return rs;
	}
}
