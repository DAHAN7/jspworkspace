package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.MemberService;
import service.MemberServiceImpl;
import util.FactoryUtil;

/**
 * 회원 관련 요청을 처리하는 서블릿 클래스
 */
@WebServlet("*.mc")  // .mc로 끝나는 모든 요청을 이 서블릿에서 처리하도록 매핑
public class MemberController extends HttpServlet{

	private static final long serialVersionUID = 7807099506362753862L;
	
	// 회원 관련 서비스 로직을 처리하는 서비스 객체 생성
	MemberService ms = new MemberServiceImpl();

	/**
	 * GET 요청을 처리하는 메서드
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberController GET 요청");
		
		// 요청된 전체 URI와 컨텍스트 경로를 추출
		String requestURI = req.getRequestURI();		// 전체 요청 경로
		String contextPath = req.getContextPath();		// 프로젝트(context) 경로
		// 전체 요청 URI에서 컨텍스트 경로를 제외한 나머지 부분을 명령어로 추출
		String command = requestURI.substring(contextPath.length());
		System.out.println("요청 : " + command);

		String nextPage = null;  // 이동할 페이지 경로를 저장할 변수
		
		// 요청된 명령어에 따라 처리 로직 수행 및 이동할 페이지 결정
		if(command.equals("/login.mc")) {
			// 로그인 페이지로 이동
			nextPage = "/member/login.jsp";
		}
		
		if(command.equals("/join.mc")) {
			// 회원가입 페이지로 이동
			nextPage = "/member/join.jsp";
		}
		
		if(command.equals("/logOut.mc")) {
			// 로그아웃 요청 처리
			System.out.println(" 로그아웃 요청 처리 ");
			ms.logOut(req, resp);  // 로그아웃 처리 로직 실행
			// 로그아웃 후 로그인 페이지로 리다이렉트
			resp.sendRedirect(contextPath+"/login.mc");
		}
		
		if(command.equals("/info.mc")) {
			// 회원 정보 페이지 요청
			nextPage = "/member/info.jsp";
		}
		
		if(command.equals("/update.mc")) {
			// 회원정보 수정 페이지 요청
			nextPage = "/member/update.jsp";
		}
		
		if(command.equals("/withdraw.mc")) {
			// 회원 탈퇴 페이지 요청
			nextPage = "/member/withdraw.jsp";
		}
		
		// 이동할 페이지가 결정되었을 경우, 해당 페이지로 포워딩
		if(nextPage != null) {
			RequestDispatcher rd = req.getRequestDispatcher(nextPage);
			rd.forward(req, resp);
		}
	}

	/**
	 * POST 요청을 처리하는 메서드
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("MemberController POST 요청");
		
		// FactoryUtil을 이용하여 요청된 명령어를 추출
		String command = FactoryUtil.getCommand(req);
		
		String nextPage = null;  // 이동할 페이지 경로를 저장할 변수
		
		// 요청된 명령어에 따라 처리 로직 수행
		if(command.equals("join.mc")) {
			// 회원가입 처리 요청
			boolean isJoin = ms.memberJoin(req);
			
			if(isJoin) {
				// 회원가입 성공 시 로그인 페이지로 이동
				req.setAttribute("msg", "회원가입 성공!");
				nextPage = "/member/login.jsp";
			}else {
				// 회원가입 실패 시 다시 회원가입 페이지로 이동
				req.setAttribute("msg", "회원가입 실패!");
				nextPage = "/member/join.jsp";
			}
		}
		
		if(command.equals("login.mc")) {
			// 로그인 처리 요청
			boolean isLogin = ms.memberLogin(req, resp);
			if(isLogin) {
				// 로그인 성공 시 메인 페이지로 리다이렉트
				resp.sendRedirect(req.getContextPath());
			}else {
				// 로그인 실패 시 로그인 페이지로 이동
				req.setAttribute("msg", "로그인 실패");
				nextPage = "/member/login.jsp";
			}
		}
		
		if(command.equals("update.mc")) {
			// 회원정보 수정 요청 처리
			ms.memberUpdate(req, resp);
		}
		
		if(command.equals("withdrawSubmit.mc")) {
			// 회원 탈퇴 요청 처리
			ms.withdraw(req, resp);
		}
		
		// 이동할 페이지가 결정되었을 경우, 해당 페이지로 포워딩
		if(nextPage != null) {
			req.getRequestDispatcher(nextPage).forward(req, resp);
		}
	} // end doPost
	
}
