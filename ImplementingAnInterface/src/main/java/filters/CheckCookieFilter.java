package filters;

import java.io.IOException;

import dao.MemberDAO;
import dao.MemberDAOImpl;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vo.MemberVO;

public class CheckCookieFilter extends HttpFilter implements Filter {
	
	private static final long serialVersionUID = -6746943554017516750L;
	
	MemberDAO dao;
	
	/**
	 * url-pattern 에 지정된 형식에 맞는 요청 마다 호출되는 method
	 */
	public void doFilter(
			ServletRequest req, 
			ServletResponse res, 
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest)req;
		
		Cookie[] cookies = request.getCookies();
		HttpSession session = request.getSession();
		
		if(cookies != null && session.getAttribute("member") == null) {
			for(Cookie cookie : cookies) {
				String name = cookie.getName();
				if(name.equals("id")) {
					// cookie에 등록된 사용자 id
					String id = cookie.getValue();
					
					MemberDAO dao = new MemberDAOImpl();
					
					MemberVO member = dao.getMemberById(id);
					
					if(member != null) {
						session.setAttribute("member", member);
					}
					break;
				} // end check cookie
			} // end for
		}
		
		chain.doFilter(req, res);
		
	}
	
}
