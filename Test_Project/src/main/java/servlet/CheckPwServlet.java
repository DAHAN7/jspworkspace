package servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class CheckPwServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		String userPw = (String) session.getAttribute("userPw");
		String password = request.getParameter("password");

		if (userPw != null && userPw.equals(password)) {
			// 비밀번호 확인 성공 시 처리할 로직
			String action = request.getParameter("action");
			if ("secede".equals(action)) {
				// 회원탈퇴 페이지
				response.sendRedirect("member/secede.jsp?user=" + userId);
			} else {
				// 개인정보수정 페이지
				response.sendRedirect("member/myPage_Member.jsp?user=" + userId);
			}
		} else {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('비밀번호가 일치하지 않습니다. 다시 시도해 주세요.'); history.back();</script>");
		}
	}
}
