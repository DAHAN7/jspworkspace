package service;

import dao.MemberDAO;
import dao.MemberDAOImpl;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.MemberVO;

public class MemberServiceImpl implements MemberService{
	
	MemberDAO dao = new MemberDAOImpl();

	@Override
	public boolean memberJoin(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String name = request.getParameter("name");
		
		MemberVO member = new MemberVO(id,pass,name);
		
		return dao.memberJoin(member);
	}

	@Override
	public boolean memberLogin(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		MemberVO member = dao.memberLogin(id, pass);
		
		if(member != null) {
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			
			String check = request.getParameter("check");
			if(check != null) {
				Cookie cookie = new Cookie("id", id);
				cookie.setMaxAge(60 * 60 * 24 * 15); // 초단위
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			return true;
		}
		return false;
	}

	@Override
	public void logOut(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		// session.invalidate();
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie c : cookies) {
				if(c.getName().equals("id")) {
					Cookie cookie = new Cookie("id","");
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
					break;
				}
			}
		}
	}
}







