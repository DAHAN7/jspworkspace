package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

// 데이터베이스 연결 및 자원 해제를 도와주는 유틸리티 클래스
public class DBCPUtil {

    // 데이터베이스 연결을 생성하고 반환하는 메서드
	public static Connection getConnection() {
		Connection conn = null;
		try {
			/*
			// 실제 운영 환경에서는 JNDI를 통해 데이터베이스 연결 풀(DataSource)을 조회하여 연결을 얻음
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/MySQLDB");
			conn = ds.getConnection();
			*/
			
			// 테스트 환경에서는 직접 JDBC 드라이버를 로드하고 연결을 생성
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/digital_jsp", // 데이터베이스 URL
					"digital", // 데이터베이스 사용자명
					"1234" // 데이터베이스 비밀번호
			);
			
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스를 출력
		}
		return conn; // 생성된 데이터베이스 연결 객체를 반환
	}

    // 데이터베이스 연결 및 자원을 닫는 메서드
	public static void close(AutoCloseable... closer) {
		for (AutoCloseable a : closer) {
			try {
				if (a != null) { // 자원이 null이 아닌 경우에만 닫음
					a.close();
				}
			} catch (Exception e) {
				// 자원을 닫는 과정에서 예외가 발생하더라도 무시하고 계속 실행
			}
		}
	}
}
