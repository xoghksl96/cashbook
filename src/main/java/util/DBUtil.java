package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		// 1. DB 연결
		String dbDriver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPassword = "java1234";
		
		Class.forName(dbDriver);
		Connection returnConn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
		
		return returnConn;
	}
}
