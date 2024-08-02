package util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBCPUtil {

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/MySQLDB");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println("이름 경로에 리소스를 불러올 수 없음");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("리소스는 찾았으나 설정정보가 일치 하지 않음");
			e.printStackTrace();
		}
		return conn;
	}

	public static void close(AutoCloseable... closer) {
		for (AutoCloseable a : closer) {
			try {
				if (a != null) {
					a.close();
				}
			} catch (Exception e) {
			}
		}
	}

}
