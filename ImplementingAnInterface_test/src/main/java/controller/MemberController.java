package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.MemberService;
import service.MemberServiceImpl;

// @WebServlet("*.mc")
public class MemberController extends HttpServlet{

	private static final long serialVersionUID = 7807099506362753862L;
	
	MemberService service = new MemberServiceImpl();

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String requestURI = request.getRequestURI();
		System.out.println("전체 요청 경로 : " + requestURI);
		String contextPath = request.getContextPath();
		System.out.println("요청 프로젝트 경로 : " + contextPath);
		String command = requestURI.substring(contextPath.length()+1);
		System.out.println("contextPath를 제외한 요청 경로 : " + command);
		
		// 요청에 따라 출력할 jsp page 경로
		String nextPage = null;
		
		if(command.equals("login.mc")) {
			nextPage = "/member/login.jsp";
		}else if(command.equals("join.mc")) {
			nextPage = "/member/join.jsp";
		}else if(command.equals("joinAction.mc")) {
			// 회원가입 요청 처리
			boolean isJoin = service.memberJoin(request);
			nextPage = isJoin ? "/member/login.jsp" : "/member/join.jsp";
		}else if(command.equals("loginSubmit.mc")) {
			boolean isLogin = service.memberLogin(request, response);
			if(isLogin) {
				response.sendRedirect(contextPath);
				return;
			}else {
				nextPage = "/member/login.jsp";
			}
		}else if(command.equals("logout.mc")) {
			service.logOut(request, response);
			response.sendRedirect("login.mc");
			return;
		}
		
		if(nextPage != null) {
			RequestDispatcher rd = request.getRequestDispatcher(nextPage);
			rd.forward(request, response);
		}
	}
}