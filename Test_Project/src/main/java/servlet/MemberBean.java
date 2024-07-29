package servlet;

import java.sql.*;

public class MemberBean {
	private String mId;
	private boolean available;
	
	public String getmId() {
		return mId;
	}
	
	public boolean isAvailable() {
		return available;
	}
	
	public void setmId(String mId) {
		this.mId = mId;
		checkId();
	}
	
	private void checkId() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "root", "1234");
			String sql = "SELECT COUNT(*) FROM member WHERE memberId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			rs  = pstmt.executeQuery();
			
			if (rs.next()) {
				int count = rs.getInt(1);
				available = (count == 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			available = false;
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
		}	
	}
	
}