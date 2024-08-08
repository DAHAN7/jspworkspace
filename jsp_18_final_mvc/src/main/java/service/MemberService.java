package service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 데이터 처리에 필요한 알맞은 정보를 가공하는 과정을 처리하는 클래스입니다.
 * 이 인터페이스는 비즈니스 로직을 수행하며, 회원 관련 서비스 메서드를 정의합니다.
 * 
 * @since 2024-07-30
 */
public interface MemberService {
	
	/**
	 * 회원 가입 요청을 처리하는 메서드입니다.
	 * 
	 * @param request - 회원 가입에 필요한 정보를 포함하는 HttpServletRequest 객체
	 * @return boolean - 회원 가입 성공 여부를 반환합니다. (true: 성공, false: 실패)
	 */
	boolean memberJoin(HttpServletRequest request);
	
	/**
	 * 로그인 요청을 처리하는 메서드입니다.
	 * 
	 * @param request - 로그인 요청에 필요한 파라미터를 포함하는 HttpServletRequest 객체
	 * @param response - 로그인 처리 결과를 클라이언트에 응답하기 위한 HttpServletResponse 객체
	 * @return boolean - 로그인 성공 여부를 반환합니다.
	 */
	boolean memberLogin(HttpServletRequest request, HttpServletResponse response);
	
	/**
	 * 회원 정보를 수정하는 요청을 처리하는 메서드입니다.
	 * 
	 * @param request - 회원 정보 수정에 필요한 파라미터를 포함하는 HttpServletRequest 객체
	 * @param response - 수정 처리 결과를 클라이언트에 응답하기 위한 HttpServletResponse 객체
	 */
	void memberUpdate(HttpServletRequest request, HttpServletResponse response);
	
	/**
	 * 회원 탈퇴 요청을 처리하는 메서드입니다.
	 * 
	 * @param request - 회원 탈퇴 시 사용자가 입력한 비밀번호를 포함하는 HttpServletRequest 객체
	 * @param response - 탈퇴 요청 처리 결과를 클라이언트에 응답하기 위한 HttpServletResponse 객체
	 */
	void withdraw(HttpServletRequest request, HttpServletResponse response);
	
	/**
	 * 로그아웃 요청을 처리하는 메서드입니다.
	 * 
	 * @param request - 로그아웃 요청 처리에 필요한 세션 정보를 포함하는 HttpServletRequest 객체
	 * @param response - 로그아웃 처리 후 쿠키 정보를 삭제하기 위한 HttpServletResponse 객체
	 */
	void logOut(HttpServletRequest request, HttpServletResponse response);
}
