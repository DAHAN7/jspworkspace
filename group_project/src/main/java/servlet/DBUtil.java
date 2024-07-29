package servlet;

import java.sql.*;

public class DBUtil {
	// DB 연결
	public static Connection getConnection() {
		Connection conn = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "root", "1234");

		} catch (ClassNotFoundException e) {
			System.out.println("Driver Class를 찾을 수 없음");
		} catch (SQLException e) {
			System.out.println("연결 요청 정보 오류 : " + e.getMessage());
		}
		return conn;
	}

	public static void close(AutoCloseable... closer) {
		for (AutoCloseable c : closer) {
			if (c != null) {
				try {
					c.close();
				} catch (Exception e) {
				}
			}
		} // end for
	} // end close
}
