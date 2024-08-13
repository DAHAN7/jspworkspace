package filters;

import java.io.IOException;

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
	
	MemberDAOImpl dao = new MemberDAOImpl();
	
	/**
	 * url-pattern 에 지정된 형식에 맞는 요청 마다 호출되는 method
	 */
	public void doFilter(
			ServletRequest req, 
			ServletResponse res, 
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest)req;
		Cookie[] cookies = request.getCookies();
		if(cookies !=null) {
			for(Cookie c : cookies) {
				if(c.getName().equals("id")) {
					String id = c.getValue();
					MemberVO mv = dao.getMemberById(id);
					if(mv!=null) {
						HttpSession session = request.getSession();
						session.setAttribute("member", mv);
					}
					break;
				}
			}
		}
		
		chain.doFilter(req, res);
		
	}
	
}
