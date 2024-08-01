package dao;

import dto.MemberDTO;

/**
 * DataBase Access Object
 * Repository - 데이터 저장소와 연결된 작업을 처리하는 class
 */
public interface MemberDAO {
    
    /**
     * @param member - 테이블에 삽입하기 위한 회원 정보
     * @return boolean - 회원 정보를 테이블에 등록했는지 성공 여부
     */
    boolean memberJoin(MemberDTO member);
    
    /**
     * @param id - 회원 정보 검색에 필요한 사용자 아이디
     * @param pass - 회원정보 검색에 필요한 사용자 비밀번호
     * @return MemberDTO - id와 pass가 일치하는 회원 정보를 저장하는 객체
     * @return null - 일치하는 사용자 정보가 없음
     */
    MemberDTO memberLogin(String id, String pass);
    
    /**
     * @param member - 수정할 회원 정보
     * @return boolean - 회원 정보 수정 성공 여부
     */
    MemberDTO getMemberById(String id);
}
