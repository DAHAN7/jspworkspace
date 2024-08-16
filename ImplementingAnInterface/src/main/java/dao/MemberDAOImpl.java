package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBCPUtil;
import vo.MemberVO;

public class MemberDAOImpl implements MemberDAO { 
    // 2. 데이터베이스 관리자 시작! (회원 정보 관리 기능 제공)

    Connection conn; // 데이터베이스와의 연결 통로
    PreparedStatement pstmt; // SQL 질의를 준비하고 실행하는 도구
    ResultSet rs; // SQL 질의 결과를 담는 통

    // 3. 회원가입 기능
    @Override
    public boolean memberJoin(MemberVO member) { 
        // 3-1. 데이터베이스에 연결
        conn = DBCPUtil.getConnection();

        // 3-2. 회원 정보를 데이터베이스에 추가하는 SQL 질의 준비
        String sql = "INSERT INTO test_mvc(id, pass, name) VALUES(?,?,?)";

        try {
            pstmt = conn.prepareStatement(sql);
            // 3-3. SQL 질의에 값 채워 넣기
            pstmt.setString(1, member.getId()); 
            pstmt.setString(2, member.getPass());
            pstmt.setString(3, member.getName());

            // 3-4. SQL 질의 실행하고 결과 받기
            int result = pstmt.executeUpdate(); 

            if (result == 1) { 
                // 3-5. 회원가입 성공!
                return true; 
            }
        } catch (SQLException e) { 
            // 3-6. 에러 발생 시, 실패 알림
            return false; 
        } finally { 
            // 3-7. 사용한 자원 정리 (연결 닫기)
            DBCPUtil.close(pstmt, conn); 
        }
        return false; // 3-8. 기본적으로 실패 알림
    }

    // 4. 로그인 기능
    @Override
    public MemberVO memberLogin(String id, String pass) {
        MemberVO member = null; // 4-1. 결과를 담을 빈 상자 준비

        // 4-2. 데이터베이스에 연결
        conn = DBCPUtil.getConnection();

        // 4-3. 아이디와 비밀번호로 회원 정보를 조회하는 SQL 질의 준비
        String sql = "SELECT * FROM test_mvc WHERE id = ? AND pass = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            // 4-4. SQL 질의에 값 채워 넣기
            pstmt.setString(1, id);
            pstmt.setString(2, pass);

            // 4-5. SQL 질의 실행하고 결과 받기
            rs = pstmt.executeQuery();

            if (rs.next()) { 
                // 4-6. 조회 결과가 있다면 (로그인 성공)
                member = new MemberVO(); 
                // 4-6-1. 빈 상자에 데이터 채워 넣기
                member.setNum(rs.getInt(1));
                member.setId(rs.getString(2));
                member.setPass(rs.getString(3));
                member.setName(rs.getString(4));
            }
        } catch (SQLException e) { 
            // 4-7. 에러 발생 시, 출력
            e.printStackTrace(); 
        } finally {
            // 4-8. 사용한 자원 정리 (연결 닫기)
            DBCPUtil.close(rs, pstmt, conn); 
        }
        return member; // 4-9. 조회 결과 또는 null 반환
    }

    // 5. 아이디로 회원 정보 조회 기능
    @Override
    public MemberVO getMemberById(String id) {
        // 5-1. 데이터베이스에 연결
        conn = DBCPUtil.getConnection();

        // 5-2. 아이디로 회원 정보를 조회하는 SQL 질의 준비
        String sql = "SELECT * FROM test_mvc WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            // 5-3. SQL 질의에 값 채워 넣기
            pstmt.setString(1, id);

            // 5-4. SQL 질의 실행하고 결과 받기
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 5-5. 조회 결과가 있다면
                MemberVO member = new MemberVO(
                    rs.getInt(1),    // 5-5-1. 조회된 데이터로 MemberVO 객체 생성
                    rs.getString(2), 
                    rs.getString(3), 
                    rs.getString(4)
                );
                return member; // 5-5-2. 생성된 MemberVO 객체 반환
            }
        } catch (SQLException e) {
            // 5-6. 에러 발생 시, 출력
            e.printStackTrace(); 
        } finally {
            // 5-7. 사용한 자원 정리 (연결 닫기)
            DBCPUtil.close(rs, pstmt, conn);
        }
        return null; // 5-8. 조회 결과가 없다면 null 반환
    }
}