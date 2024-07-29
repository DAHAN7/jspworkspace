package servlet;

import java.sql.*;

public class MemberDAO {
	// MemberVO 객체를 DB에 저장함
	public void insertMember(MemberVO member) {
		String sql = "INSERT INTO member (memberName, memberId, memberEmail, memberPassword, memberPhone, memberBirth, memberAddr1, memberAddr2, memberAddr3, memberGender, memberType,memberNum) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getId());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getPassword());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getBirth());
			pstmt.setString(7, member.getAddr1());
			pstmt.setString(8, member.getAddr2());
			pstmt.setString(9, member.getAddr3());
			pstmt.setString(10, member.getGender());
			pstmt.setInt(11, member.getType());
			pstmt.setInt(12, member.getMemberNum());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(conn, pstmt);
		}
	}

	// 아이디로 회원 조회
	public MemberVO getMember(String memberId) {
		MemberVO member = null;
		String sql = "SELECT * FROM member WHERE memberId = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberVO();
				member.setMemberNum(rs.getInt("memberNum"));
				member.setName(rs.getString("memberName"));
				member.setId(rs.getString("memberId"));
				member.setEmail(rs.getString("memberEmail"));
				member.setPassword(rs.getString("memberPassword"));
				member.setPhone(rs.getString("memberPhone"));
				member.setBirth(rs.getString("memberBirth"));
				member.setAddr1(rs.getString("memberAddr1"));
				member.setAddr2(rs.getString("memberAddr2"));
				member.setAddr3(rs.getString("memberAddr3"));
				member.setGender(rs.getString("memberGender"));
				member.setMoney(rs.getInt("Money"));
				member.setJoinDate(rs.getTimestamp("memberJoin"));
				member.setVisitDate(rs.getTimestamp("memberVisit"));
				member.setType(rs.getInt("memberType"));
				member.setWithdraw(rs.getString("memberWithdraw"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(conn, pstmt, rs);
		}
		return member;
	}

	// DB에 저장된 비번이랑 로그인 비번이랑 비교
	public boolean checkPassword(String memberId, String current) {
		boolean isMatch = false;
		String sql = "SELECT memberPassword FROM member WHERE memberId = ? AND memberPassword = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, current);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				isMatch = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(conn, pstmt, rs);
		}
		return isMatch;
	}

	// 비밀번호 변경
	public void updatePassword(String memberId, String newPassword) {
		String sql = "UPDATE member SET memberPassword = ? WHERE memberId = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPassword);
			pstmt.setString(2, memberId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(conn, pstmt);
		}
	}

	// 비밀번호 재설정
	public void updateReset(String newPassword, String memberId, String memberEmail) {
		String sql = "UPDATE member SET memberPassword = ? WHERE memberId = ? AND memberEmail = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPassword);
			pstmt.setString(2, memberId);
			pstmt.setString(3, memberEmail);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(conn, pstmt);
		}
	}

	// 회원 탈퇴
	public boolean updateStatus(String userId) {
		String sql = "UPDATE member SET memberWithdraw = 'y' WHERE memberId = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(conn, pstmt);
		}
		return false;
	}

	// 최종 방문일
	public void updateLastVisit(String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBUtil.getConnection();
			String sql = "UPDATE member SET memberVisit = CURRENT_TIMESTAMP WHERE memberId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt, conn);
		}
	}

	// 전체 회원 수 조회
	public int getTotalMemberCount() {
		String sql = "SELECT * FROM member";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(conn, pstmt, rs);
		}
		return 0;
	}
}
