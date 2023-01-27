package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		// 1. DB 연결
		String dbDriver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://3.34.252.193:3306/cashbook";
		String dbUser = "root";
		String dbPassword = "java1234";
		
		Class.forName(dbDriver);
		Connection returnConn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
		
		return returnConn;
	}
	
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws Exception {
		rs.close();
		stmt.close();
		conn.close();
	}
	
	public void close(PreparedStatement stmt, Connection conn) throws Exception {
		stmt.close();
		conn.close();
	}
}
