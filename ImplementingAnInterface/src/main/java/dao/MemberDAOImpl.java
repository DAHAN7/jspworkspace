package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBCPUtil;
import vo.MemberVO;

public class MemberDAOImpl implements MemberDAO{

	Connection conn;
	ResultSet rs;
	PreparedStatement pstmt;
	
	
	@Override
	public boolean memberJoin(MemberVO member) {
		conn = DBCPUtil.getConnection();
		String sql = "select * from test_mvc where id = ?";
		try {
			pstmt  = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return false;
			}
			
			sql = "insert into test_mvc values(null, ?,?,?)";

			pstmt  = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			
			int RS = pstmt.executeUpdate();
			
			if(RS == 1) {
				System.out.println("TF3:" +RS);
				return true;
			}
			
			
					
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}

	@Override
	public MemberVO memberLogin(String id, String pass) {
		conn=DBCPUtil.getConnection();
		String sql = "select * from test_mvc where id=? and pass=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MemberVO mv = new MemberVO();
				mv.setNum(rs.getInt("num"));
				mv.setId(rs.getString("id"));
				mv.setPass(rs.getString("pass"));
				mv.setName(rs.getString("Name"));
				return mv;
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
	}

	@Override
	public MemberVO getMemberById(String id) {
		conn=DBCPUtil.getConnection();
		String sql = "select * from test_mvc where id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				MemberVO mv = new MemberVO();
				mv.setNum(rs.getInt("num"));
				mv.setId(rs.getString("id"));
				mv.setPass(rs.getString("pass"));
				mv.setName(rs.getString("Name"));
				return mv;
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return null;
	}


}
