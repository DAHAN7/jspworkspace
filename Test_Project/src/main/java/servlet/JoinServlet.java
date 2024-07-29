package servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class JoinServlet extends HttpServlet {

	private static final long serialVersionUID = -8888616112054876064L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 클라이언트로부터 받은 파라미터 가져오기
		String name = request.getParameter("name");
		String id = request.getParameter("mId");
		String email = request.getParameter("email");
		String password = request.getParameter("mPw");
		String phone = request.getParameter("phone");
		String birth = request.getParameter("birth");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String addr3 = request.getParameter("addr3");
		String gender = request.getParameter("gender");
		int type = Integer.parseInt(request.getParameter("type"));

		// MemberVO 객체 생성 및 값 설정
		MemberVO member = new MemberVO();
		member.setName(name);
		member.setId(id);
		member.setEmail(email);
		member.setPassword(password);
		member.setPhone(phone);
		member.setBirth(birth);
		member.setAddr1(addr1);
		member.setAddr2(addr2);
		member.setAddr3(addr3);
		member.setGender(gender);
		member.setType(type);

		// MemberDAO 를 통해 DB에 정보를 저장할 수 있음
		MemberDAO memberDAO = new MemberDAO();
		memberDAO.insertMember(member);

		request.setAttribute("member", member);

		// 로그인 페이지로 포워딩
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println("<script>alert('정상적으로 가입 완료했습니다.');</script>");
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/login.jsp");
		dispatcher.forward(request, response);

		// System.out.println("회원 정보: " + member.getName() + ", " + member.getId() + ",
		// " + member.getEmail());
	}
}