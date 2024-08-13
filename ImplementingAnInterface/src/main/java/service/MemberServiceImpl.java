package service;

import dao.MemberDAOImpl;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.MemberVO;

public class MemberServiceImpl implements MemberService{

	MemberDAOImpl dao = new MemberDAOImpl();
	@Override
	public boolean memberJoin(HttpServletRequest request) {
		MemberVO mv = new MemberVO();
		
		mv.setId(request.getParameter("id"));
		mv.setName(request.getParameter("name"));
		mv.setPass(request.getParameter("pass"));
		boolean TF = dao.memberJoin(mv);
		
		if(request.getParameter("pass").equals(request.getParameter("rePass"))) {
			if(TF) {
				System.out.println("TF2:"+TF);
				return TF;
			} else {
				request.setAttribute("msg", "회원가입 실패한듯;;;");
				return TF;
			}
			
		} else {
			request.setAttribute("msg", "비번 재확인쩜여");
			return false;
		}
	}

	@Override
	public boolean memberLogin(HttpServletRequest request, HttpServletResponse response) {
		MemberVO mv = dao.memberLogin(request.getParameter("id"), request.getParameter("pass"));
		
		String login = request.getParameter("check");
		
		
		if(mv!=null) {
			if(login!=null) {
				Cookie cookie = new Cookie("id",request.getParameter("id"));
				cookie.setMaxAge(60*60*24*7);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		HttpSession session = request.getSession();
		session.setAttribute("member", mv);
		return true;
		}
		
		
		
		
		return false;
	}

	@Override
	public void logOut(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		Cookie cookie = new Cookie("id", "");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		
	}

}
