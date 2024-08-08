package service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;

import dao.MemberDAO;
import dao.MemberDAOImpl;
import dto.MemberDTO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * MemberService 인터페이스의 구현 클래스입니다.
 * 이 클래스는 회원 관련 비즈니스 로직을 처리합니다.
 */
public class MemberServiceImpl implements MemberService {
	
	private MemberDAO dao = new MemberDAOImpl();

	/**
	 * 회원 가입을 처리하는 메서드입니다.
	 * 
	 * @param request - 회원 가입에 필요한 정보를 포함하는 HttpServletRequest 객체
	 * @return boolean - 회원 가입 성공 여부를 반환합니다. (true: 성공, false: 실패)
	 */
	@Override
	public boolean memberJoin(HttpServletRequest request) {
		
		// 요청 파라미터에서 회원 정보를 추출합니다.
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String name = request.getParameter("name");
		String ageParam = request.getParameter("age");
		String gender = request.getParameter("gender");
		int age = Integer.parseInt(ageParam);
		
		// MemberDTO 객체를 생성하여 회원 정보를 담습니다.
		MemberDTO dto = new MemberDTO(id, pass, name, age, gender);
		
		// DAO를 통해 회원 가입을 처리하고 결과를 반환합니다.
		boolean isSuccess = dao.memberJoin(dto);
		return isSuccess;
	}

	/**
	 * 로그인 처리를 하는 메서드입니다.
	 * 
	 * @param request - 로그인 요청에 필요한 정보를 포함하는 HttpServletRequest 객체
	 * @param response - 로그인 처리 결과를 클라이언트에 응답하기 위한 HttpServletResponse 객체
	 * @return boolean - 로그인 성공 여부를 반환합니다.
	 */
	@Override
	public boolean memberLogin(HttpServletRequest request, HttpServletResponse response) {
		
		// 요청 파라미터에서 로그인 정보를 추출합니다.
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String login = request.getParameter("login");
		
		// DAO를 통해 로그인 처리를 시도합니다.
		MemberDTO member = dao.memberLogin(id, pass);
		
		if (member != null) {
			// 로그인 성공 시 세션에 사용자 정보를 저장합니다.
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			
			if (login != null) {
				// 자동 로그인 체크박스가 체크된 경우, 쿠키에 사용자 ID를 저장합니다.
				byte[] bytes = Base64.getEncoder().encode(id.getBytes());
				System.out.println("원본 아이디 : " + id);
				id = new String(bytes);
				System.out.println("encoding id : " + id);
				Cookie cookie = new Cookie("id", id);
				cookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키의 유효기간을 1주일로 설정
				cookie.setPath("/"); // 쿠키가 유효한 경로를 지정
				response.addCookie(cookie);
			}
			return true;
		}
		
		return false;
	}

	/**
	 * 회원 정보를 수정하는 메서드입니다.
	 * 
	 * @param request - 회원 정보 수정에 필요한 파라미터를 포함하는 HttpServletRequest 객체
	 * @param response - 수정 결과를 클라이언트에 응답하기 위한 HttpServletResponse 객체
	 */
	@Override
	public void memberUpdate(HttpServletRequest request, HttpServletResponse response) {
		
		// 요청 파라미터에서 회원 정보를 추출하여 MemberDTO 객체를 생성합니다.
		MemberDTO member = new MemberDTO(
			request.getParameter("id"),
			request.getParameter("pass"),
			request.getParameter("name"),
			Integer.parseInt(request.getParameter("age")),
			request.getParameter("gender")
		);
		System.out.println("update member : " + member);
		
		// DAO를 통해 회원 정보 수정을 처리합니다.
		boolean isUpdate = dao.memberUpdate(member);
		
		try {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if (isUpdate) {
				// 수정 성공 시 세션 정보를 갱신하고 사용자에게 알림을 띄웁니다.
				MemberDTO m = dao.getMemberById(member.getId());
				request.getSession().setAttribute("member", m);
				out.println("alert('수정 성공');");
				out.println("location.href='info.mc';"); // 수정 후 페이지 이동
			} else {
				// 수정 실패 시 사용자에게 알림을 띄웁니다.
				out.println("alert('수정 실패');");
				out.println("history.go(-1);"); // 이전 페이지로 돌아갑니다.
			}
			out.println("</script>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 회원 탈퇴를 처리하는 메서드입니다.
	 * 
	 * @param request - 회원 탈퇴 요청에 필요한 파라미터를 포함하는 HttpServletRequest 객체
	 * @param response - 탈퇴 처리 결과를 클라이언트에 응답하기 위한 HttpServletResponse 객체
	 */
	@Override
	public void withdraw(HttpServletRequest request, HttpServletResponse response) {
		// 회원 탈퇴를 요청한 사용자가 로그인한 사용자인지 확인하기 위해 비밀번호를 입력받습니다.
		String tempPass = request.getParameter("tempPass");
		System.out.println("tempPass : " + tempPass);
		
		HttpSession session = request.getSession();
		// 세션에 저장된 로그인 사용자 정보를 가져옵니다.
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		try {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter print = response.getWriter();
			
			print.println("<script>");
			if (member != null && member.getPass().equals(tempPass)) {
				// 비밀번호가 일치할 경우 회원 탈퇴를 처리합니다.
				boolean isDeleted = dao.deleteMember(member.getNum());
				if (isDeleted) {
					// 탈퇴 성공 시 로그아웃 처리를 하고 사용자에게 알림을 띄웁니다.
					logOut(request, response);
					print.println("alert('회원탈퇴 성공! 빠이~');");
					print.println("location.href='test';"); // 탈퇴 후 페이지 이동
				} else {
					// 탈퇴 실패 시 사용자에게 알림을 띄웁니다.
					print.println("alert('정상적으로 처리못했습니다. 다시 요청해주세요.');");
					print.println("history.back();"); // 이전 페이지로 돌아갑니다.
				}
			} else {
				// 로그인 되어 있지 않거나 비밀번호가 일치하지 않을 경우
				print.println("alert('회원탈퇴 실패! 정보가 일치하지 않습니다.');");
				print.println("history.go(-1);"); // 이전 페이지로 돌아갑니다.
			}
			print.println("</script>");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 로그아웃을 처리하는 메서드입니다.
	 * 
	 * @param request - 로그아웃 처리에 필요한 세션 정보를 포함하는 HttpServletRequest 객체
	 * @param response - 로그아웃 처리 후 쿠키 정보를 제거하기 위한 HttpServletResponse 객체
	 */
	@Override
	public void logOut(HttpServletRequest request, HttpServletResponse response) {
		// 현재 세션을 무효화하여 사용자 정보를 삭제합니다.
		HttpSession session = request.getSession();
		session.invalidate();
		
		// 자동 로그인 쿠키가 설정되어 있다면 쿠키 정보를 제거합니다.
		Cookie cookie = new Cookie("id", "");
		cookie.setMaxAge(0); // 쿠키를 즉시 만료시키기 위해 최대 나이를 0으로 설정
		cookie.setPath("/"); // 쿠키가 유효한 경로를 지정
		response.addCookie(cookie);
	}
}
