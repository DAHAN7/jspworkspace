package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBCPUtil;

public class QnABoardDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public boolean boardWrite(String qna_title, String qna_content, int qna_writer_num) {
		
		conn = DBCPUtil.getConnection();
		
		String sql = " INSERT INTO qna_board(qna_title,qna_content,qna_writer_num) "
					+" VALUES(?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qna_title);
			pstmt.setString(2, qna_content);
			pstmt.setInt(3, qna_writer_num);
			
			int result = pstmt.executeUpdate();
			
			if(result == 1) return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(pstmt, conn);
		}
		return false;
	} // end noticeWrite method

}












