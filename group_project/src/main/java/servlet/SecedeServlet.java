package servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class SecedeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		String secedeChk = request.getParameter("secedeChk");

		if (userId != null && "회원탈퇴".equals(secedeChk)) {
			MemberDAO memberDAO = new MemberDAO();
			boolean success = memberDAO.updateStatus(userId);
			if (success) {
				session.invalidate(); // 세션 무효화
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('성공적으로 회원 탈퇴하였습니다.');</script>");
				response.sendRedirect("index.jsp"); // 메인 페이지로 리다이렉트 일단 로그아웃 서블릿으로 던져봄
			} else {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('회원 탈퇴에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
			}
		} else {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('입력한 값이 잘못되었습니다.'); history.back();</script>");
		}
	}
}
