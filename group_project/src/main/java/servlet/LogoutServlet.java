package servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			String userId = (String) session.getAttribute("userId");
			
			Cookie cookie = new Cookie("memberId", "");
			cookie.setMaxAge(0);
			cookie.setPath("/");
			
			response.addCookie(cookie);
			if (userId != null) {
				MemberDAO memberDAO = new MemberDAO();
				memberDAO.updateLastVisit(userId);
			}
			// 세션 무효화
			session.invalidate();
		}
		// 나중에 메인 페이지로 경로 수정
		response.sendRedirect("index.jsp");
	}
}