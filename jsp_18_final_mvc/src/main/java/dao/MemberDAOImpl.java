package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MemberDTO;

public class MemberDAOImpl implements MemberDAO {
	
	Connection conn;            // 데이터베이스 연결 객체
	PreparedStatement pstmt;    // SQL 문 실행을 위한 객체
	ResultSet rs;               // SQL 실행 결과를 담는 객체
	
	/**
	 * 데이터베이스 연결을 설정하는 메서드
	 */
	public void setConnection() {
		try {
			// JDBC 드라이버 로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스 연결 설정
			conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/digital_jsp",  // 데이터베이스 URL
				"digital",                                  // 사용자명
				"1234"                                      // 비밀번호
			);
		} catch (ClassNotFoundException e) {
			e.printStackTrace(); // 드라이버 로드 실패 예외 처리
		} catch (SQLException e) {
			e.printStackTrace(); // 데이터베이스 연결 실패 예외 처리
		}
	}
	
	/**
	 * 데이터베이스 리소스를 해제하는 메서드
	 */
	public void close() {
		// ResultSet 객체 닫기
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		// PreparedStatement 객체 닫기
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		
		// Connection 객체 닫기
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	} // end close
	

	/**
	 * 회원가입을 처리하는 메서드
	 * @param member - 가입할 회원 정보를 담고 있는 객체
	 * @return boolean - 회원가입 성공 여부를 반환 (true: 성공, false: 실패)
	 */
	@Override
	public boolean memberJoin(MemberDTO member) {
		
		setConnection();  // 데이터베이스 연결 설정
		
		// 중복 아이디 확인을 위한 SQL 쿼리
		String sql = "SELECT * FROM mvc_member WHERE id = ?"
					+ " UNION "
					+ "SELECT * FROM mvc_member_backup WHERE id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getId());
			rs = pstmt.executeQuery();
			
			// 중복된 아이디가 존재하는 경우
			if(rs.next()) {
				return false;
			}
			
			// 중복되지 않은 경우, 회원 정보 삽입
			sql = "INSERT INTO mvc_member(id, pass, name, age, gender) VALUES(?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			pstmt.setInt(4, member.getAge());
			pstmt.setString(5, member.getGender());
			int result = pstmt.executeUpdate();
			
			// 삽입 성공 여부 확인
			if(result == 1) {
				return true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			// 리소스 해제
			this.close();
		}
		return false;
	}

	/**
	 * 회원 로그인을 처리하는 메서드
	 * @param id - 회원의 아이디
	 * @param pass - 회원의 비밀번호
	 * @return MemberDTO - 로그인 성공 시 회원 정보를 반환, 실패 시 null 반환
	 */
	@Override
	public MemberDTO memberLogin(String id, String pass) {
		
		MemberDTO member = null;
		this.setConnection();  // 데이터베이스 연결 설정
		
		// 로그인 확인을 위한 SQL 쿼리
		String sql = "SELECT * FROM mvc_member WHERE id = ? AND pass = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			// 아이디와 비밀번호가 일치하는 회원 정보가 있는 경우
			if(rs.next()) {
				member = new MemberDTO();
				member.setNum(rs.getInt(1));              // 회원 번호
				member.setName(rs.getString("name"));      // 회원 이름
				member.setId(id);                          // 회원 아이디
				member.setPass(pass);                      // 회원 비밀번호
				member.setAge(rs.getInt("age"));           // 회원 나이
				member.setGender(rs.getString("gender"));  // 회원 성별
				member.setRegdate(rs.getTimestamp("regdate"));  // 가입일
				member.setUpdatedate(rs.getTimestamp("updatedate"));  // 수정일
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 리소스 해제
			this.close();
		}
		return member;
	}

	/**
	 * 회원 정보 수정을 처리하는 메서드
	 * @param member - 수정할 회원 정보를 담고 있는 객체
	 * @return boolean - 회원 정보 수정 성공 여부를 반환 (true: 성공, false: 실패)
	 */
	@Override
	public boolean memberUpdate(MemberDTO member) {
		this.setConnection();  // 데이터베이스 연결 설정
		
		// 회원 정보 수정을 위한 SQL 쿼리
		String sql = "UPDATE mvc_member SET pass = ?, name = ?, age = ?, gender = ?, "
				   + "updatedate = now() WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPass());
			pstmt.setString(2, member.getName());
			pstmt.setInt(3, member.getAge());
			pstmt.setString(4, member.getGender());
			pstmt.setString(5, member.getId());
			
			int result = pstmt.executeUpdate();
			
			// 수정 성공 여부 확인
			if(result == 1) return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 리소스 해제
			this.close();
		}
		return false;
	}

	/**
	 * 회원 탈퇴를 처리하는 메서드
	 * @param num - 탈퇴할 회원의 고유 번호
	 * @return boolean - 회원 탈퇴 성공 여부를 반환 (true: 성공, false: 실패)
	 */
	@Override
	public boolean deleteMember(int num) {
		this.setConnection();  // 데이터베이스 연결 설정
		
		try {
			// 회원 정보 삭제를 위한 SQL 쿼리
			String sql = "DELETE FROM mvc_member WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			int result = pstmt.executeUpdate();
			
			// 삭제 성공 여부 확인
			if(result == 1) return true;

			// 백업 및 삭제 절차 코드 (주석 처리됨)
			/*
			String sql = "SELECT * FROM mvc_member WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String id = rs.getString("id");
				String pass = rs.getString("pass");
				String name = rs.getString("name");
				int age = rs.getInt("age");
				String gender = rs.getString("gender");
				Timestamp regdate = rs.getTimestamp("regdate");
				
				sql = "INSERT INTO mvc_member_backup VALUES(?,?,?,?,?,?,?,now())";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				pstmt.setString(3, pass);
				pstmt.setString(4, name);
				pstmt.setInt(5, age);
				pstmt.setString(6, gender);
				pstmt.setTimestamp(7, regdate);
				
				int result = pstmt.executeUpdate();
				
				if(result == 1){
					sql = "DELETE FROM mvc_member WHERE num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					result = pstmt.executeUpdate();
					
					if(result == 1) return true;
				}
			}
			*/
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 리소스 해제
			this.close();
		}
		return false;
	}

	/**
	 * 회원 ID로 회원 정보를 검색하는 메서드 (자동 로그인 시 사용)
	 * @param id - 검색할 회원 ID
	 * @return MemberDTO - 해당 ID에 일치하는 회원 정보를 반환, 없으면 null 반환
	 */
	@Override
	public MemberDTO getMemberById(String id) {
		MemberDTO member = null;
		this.setConnection();  // 데이터베이스 연결 설정
		
		// ID로 회원 정보를 검색하는 SQL 쿼리
		String sql = "SELECT * FROM mvc_member WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			// 해당 ID에 일치하는 회원 정보가 있는 경우
			if(rs.next()) {
				member = new MemberDTO(
					rs.getInt(1),				// 회원 번호
					rs.getString(2),			// 회원 ID
					rs.getString(3),			// 회원 비밀번호
					rs.getString(4),			// 회원 이름
					rs.getInt(5),				// 회원 나이
					rs.getString(6),			// 회원 성별
					rs.getTimestamp(7),			// 가입일
					rs.getTimestamp(8)			// 수정일
				);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 리소스 해제
			this.close();
		}
		
		return member;
	}

}
