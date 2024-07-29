/* 
데이터베이스 연결 페이지 만들기 
mysql-connector-java-8.0.29.jar 라이브러리를 lib 폴더에 저장하고 자바와 데이터베이스를 연결하는 페이지 작성
데이터베이스 연결이 필요한 페이지에서 해당 파일을 include
*/

package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * database 연결 작업 및 자원해제 담당 class
 */
public class JDBCUtil {
	
	/**
	 * 새로운 Connection 객체 생성 및 반환 
	 */
	
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/baskin",	
				"root",									
				"1234"			
			);
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Class를 찾을 수 없음");
		} catch (SQLException e) {
			System.out.println("연결 요청 정보 오류 : " + e.getMessage());
		}
		return conn;
		
	} // end getConnection() 	

	/**
	 * 매개변수로 전달 받은 외부자원 사용 class 의 자원해제
	 */
	// ... -> 가변형 인자열
	public static void close(AutoCloseable... closer) {
		for(AutoCloseable c : closer) {
			if(c != null) {
				try {
					c.close();
				} catch (Exception e) {}
			}
		}
		
	}
	
	// close 3종 주석처리
	/*
	public static void close(Connection conn) {
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {}
		}
	} // end close
	
	public static void close(ResultSet rs) {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {}
		}
	} // end close
	
	public static void close(Statement stmt) {
		if(stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {}
		}
	} // end close
	*/
	
	
} // end class






