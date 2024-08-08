package dao;

import dto.MemberDTO;

/**
 * DataBase Access Object
 * Repository - 데이터 저장소와 연결된 작업을 처리하는 인터페이스
 * 회원 관련 데이터베이스 작업을 정의합니다.
 */
public interface MemberDAO {
	
	/**
	 * 회원 가입을 처리하는 메서드
	 * @param member - 데이터베이스의 회원 테이블에 삽입할 회원 정보를 담고 있는 객체
	 * @return boolean - 회원정보를 테이블에 성공적으로 등록했는지 여부를 반환 (true: 성공, false: 실패)
	 */
	boolean memberJoin(MemberDTO member);
	
	/**
	 * 회원 로그인을 처리하는 메서드
	 * @param id - 로그인하려는 회원의 ID
	 * @param pass - 로그인하려는 회원의 비밀번호
	 * @return MemberDTO - 입력된 ID와 비밀번호가 일치하는 회원 정보를 반환
	 * @return null - 일치하는 회원 정보가 없는 경우 null을 반환
	 */
	MemberDTO memberLogin(String id, String pass);
	
	/**
	 * 회원 정보를 수정하는 메서드
	 * @param member - 수정할 회원 정보를 담고 있는 객체
	 * @return boolean - 회원 정보 수정이 성공적으로 이루어졌는지 여부를 반환 (true: 성공, false: 실패)
	 */
	boolean memberUpdate(MemberDTO member);
	
	/**
	 * 회원 탈퇴를 처리하는 메서드
	 * @param num - 탈퇴하려는 회원의 고유 번호
	 * @return boolean - 회원 정보 삭제가 성공적으로 이루어졌는지 여부를 반환 (true: 성공, false: 실패)
	 */
	boolean deleteMember(int num);
	
	/**
	 * ID로 회원 정보를 검색하는 메서드 (자동 로그인 시 사용)
	 * @param id - 데이터베이스에서 검색할 회원 ID
	 * @return MemberDTO - 입력된 ID와 일치하는 회원 정보를 반환
	 * @return null - 일치하는 회원 정보가 없는 경우 null을 반환
	 */
	MemberDTO getMemberById(String id);
}
