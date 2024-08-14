package controller;

import java.io.IOException;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.MemberServiceImpl;

@WebServlet("*.mc")
public class MemberController<MeberSeviceImpl> extends HttpServlet{
	private static final long serialVersionUID = 7807099506362753862L;
	MemberServiceImpl MS = new MemberServiceImpl();
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI=request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length()+1);
		String nextPage=null;
		
		if(command.equals("login.mc")) {
			nextPage="/member/login.jsp";
		}
		if(command.equals("join.mc")) {
			nextPage="/member/join.jsp";
		}
		if(command.equals("joinSubmit.mc")) {
			boolean TF = MS .memberJoin(request);
			System.out.println("TF"+TF);
			if(TF) {
				nextPage="/member/login.jsp";
			}else {
				nextPage="/member/join.jsp";
			}
		}
		if(command.equals("loginSubmit.mc")) {
			boolean TF= MS.memberLogin(request, response);
			System.out.println("TF"+TF);
			if(TF) {
				response.sendRedirect(contextPath);
			}else {
				nextPage="/member/login.jsp";
			}
		}
		if(command.equals("logout.mc")) {
			MS.logOut(request, response);
			response.sendRedirect(contextPath);

		}
		if(nextPage !=null) {
			RequestDispatcher rd= request.getRequestDispatcher(nextPage);
			rd.forward(request, response);
		}
	}

}
