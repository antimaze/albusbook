package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.PreparedStatement;

public class utilityClass {
	
	Connection con;
	
	public Connection getConnection() throws SQLException, ClassNotFoundException
	{
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection("jdbc:mysql://localhost/newcompany?useUnicode=true&amp;characterEncode=UTF-8","root","");	
		return con;
		
	}
	
	public Statement utility(Connection con) throws ClassNotFoundException, SQLException
	{	
		Statement st=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		
		return st;
	}
	
	public void closeConnection() throws SQLException
	{
		con.close();
	}
}
