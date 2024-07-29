package servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ChangePwServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String current = request.getParameter("current");
		String newPw = request.getParameter("newPw");
		String newPwChk = request.getParameter("newPwChk");

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");

		// 응답 문자 인코딩 설정
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter(); // PrintWriter 객체를 생성합니다.
		
		if (userId == null) {
			response.sendRedirect("member/login.jsp");
			return;
		}

		// 비밀번호 확인 및 변경 처리
		MemberDAO memberDAO = new MemberDAO();
		boolean isPwCheck = memberDAO.checkPassword(userId, current);

		if (isPwCheck) {
			if (newPw.equals(newPwChk)) {
				// 비밀번호 변경
				memberDAO.updatePassword(userId, newPw);
				// 비밀번호 변경 후 세션의 비밀번호 업데이트
				session.setAttribute("userPw", newPw);
				// 비밀번호 변경 완료 후 메인 페이지로 리다이렉트
				out.println("<script>alert('새로운 비밀번호로 변경되었습니다.');</script>");
				out.println("<script>history.go(-2);</script>");
			} else {
				// 새 비밀번호와 확인 비밀번호 불일치
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('새 비밀번호를 다시 확인해 주세요.'); history.back();</script>");
			}
		} else {
			// 현재 비밀번호 불일치
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('현재 사용하고 있는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
		}
	}
}
