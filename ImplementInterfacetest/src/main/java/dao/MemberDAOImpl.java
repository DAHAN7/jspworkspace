package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBCPUtil;
import vo.MemberVO;

public class MemberDAOImpl implements MemberDAO {
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;

	@Override
	public boolean memberJoin(MemberVO member) {
		
		conn = DBCPUtil.getConnection();
		String sql = "INSERT INTO test_mvc(id, pass, name) VALUES(?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			
			int result = pstmt.executeUpdate();
			if(result == 1) {
				return true;
			}
		} catch (SQLException e) {
			return false;
		} finally {
			DBCPUtil.close(pstmt , conn);
		}
		return false;
	}

	@Override
	public MemberVO memberLogin(String id, String pass) {
		MemberVO member = null;
		
		conn = DBCPUtil.getConnection();
		String sql = "SELECT * FROM test_mvc WHERE id = ? AND pass = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO();
				member.setNum(rs.getInt(1));
				member.setId(rs.getString(2));
				member.setPass(rs.getString(3));
				member.setName(rs.getString(4));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(rs, pstmt, conn);
		}
		return member;
	}

	@Override
	public MemberVO getMemberById(String id) {
		
		conn = DBCPUtil.getConnection();
		String sql = "SELECT * FROM test_mvc WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				MemberVO member = new MemberVO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4)
				);
				return member;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBCPUtil.close(rs,pstmt,conn);
		}
		return null;
	}

}




