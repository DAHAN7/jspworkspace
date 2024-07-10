package utils;// utils 패키지에 속하는 클래스

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
			// 1. JDBC 드라이버 로드 (MySQL Connector/J)
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 2. 데이터베이스 연결 정보 설정 및 연결 시도
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_jsp", // 데이터베이스 URL
					"digital", // 사용자 이름
					"1234"// 비밀번호
			);
		} catch (ClassNotFoundException e) { // JDBC 드라이버를 찾지 못했을 때 예외 처리
			System.out.println("Driver Class를 찾을 수 없음");
		} catch (SQLException e) { // 연결 관련 예외 발생 시 예외 처리
			System.out.println("연결 요청 정보 오류 : " + e.getMessage());
		}
		return conn; // 연결 객체 반환
	} // end getConnection()

	/**
	 * 매개변수로 전달 받은 외부자원 사용 class 의 자원해제
	 */
	// ... => 가변형 인자열
	public static void close(AutoCloseable... closer) {// 가변 인자를 사용하여 여러 자원을 한 번에 처리
		for (AutoCloseable c : closer) {
			if (c != null) {
				try {
					c.close(); // 자원 닫기 시도
				} catch (Exception e) { // 닫는 과정에서 예외 발생 시 무시 (로그 기록 등 추가 처리 가능)
					// 예외 무시
				}
			}
		} // end for
	} // end close

	/*
	 * public static void close(Connection conn) { if(conn != null) { try {
	 * conn.close(); } catch (SQLException e) {} } } // end close // 이전에 사용하던 개별 자원
	 * 해제 메서드들은 AutoCloseable을 사용하는 close 메서드로 대체되었습니다. public static void
	 * close(ResultSet rs) { if(rs != null) { try { rs.close(); } catch
	 * (SQLException e) {} } } // end close
	 * 
	 * public static void close(Statement stmt) { if(stmt != null) { try {
	 * stmt.close(); } catch (SQLException e) {} } } // end close
	 */
}
