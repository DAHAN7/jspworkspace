package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.MemberService;
import service.MemberServiceImpl;
//@WebServlet("*.mc") 
public class MemberController extends HttpServlet { 
    // 3. 컨트롤러 시작! (회원 관련 요청 처리)

    MemberService service = new MemberServiceImpl(); 
    // 4. 회원 관리 서비스에게 일 시키기

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        // 5. 모든 요청이 들어오면 실행되는 핵심 기능

        // 5-1. 요청 정보 분석하기 (어떤 페이지를 요청했는지 확인)
        String requestURI = request.getRequestURI(); 
        System.out.println("전체 요청 경로 : " + requestURI); 
        String contextPath = request.getContextPath(); 
        System.out.println("요청 프로젝트 경로 : " + contextPath); 
        String command = requestURI.substring(contextPath.length() + 1); 
        System.out.println("contextPath를 제외한 요청 경로 : " + command); 

        // 5-2. 요청에 따라 보여줄 페이지 결정하기
        String nextPage = null;

        if (command.equals("login.mc")) { 
            // 5-2-1. 로그인 페이지 요청
            nextPage = "/member/login.jsp"; 
        } else if (command.equals("join.mc")) { 
            // 5-2-2. 회원가입 페이지 요청
            nextPage = "/member/join.jsp"; 
        } else if (command.equals("joinAction.mc")) { 
            // 5-2-3. 회원가입 처리 요청
            boolean isJoin = service.memberJoin(request); // 5-2-3-1. 회원가입 서비스 실행
            nextPage = isJoin ? "/member/login.jsp" : "/member/join.jsp"; 
            // 5-2-3-2. 성공하면 로그인 페이지, 실패하면 다시 회원가입 페이지
        } else if (command.equals("loginSubmit.mc")) { 
            // 5-2-4. 로그인 처리 요청
            boolean isLogin = service.memberLogin(request, response); // 5-2-4-1. 로그인 서비스 실행
            if (isLogin) { 
                // 5-2-4-2. 로그인 성공!
                response.sendRedirect(contextPath); // 5-2-4-2-1. 메인 페이지로 이동
                return; // 5-2-4-2-2. 더 이상 처리할 필요 없음
            } else {
                // 5-2-4-3. 로그인 실패!
                nextPage = "/member/login.jsp"; // 5-2-4-3-1. 다시 로그인 페이지로
            }
        } else if (command.equals("logout.mc")) {
            // 5-2-5. 로그아웃 요청
            service.logOut(request, response); // 5-2-5-1. 로그아웃 서비스 실행
            response.sendRedirect("login.mc"); // 5-2-5-2. 로그인 페이지로 이동
            return; // 5-2-5-3. 더 이상 처리할 필요 없음
        }

        if (nextPage != null) { 
            // 5-3. 결정된 페이지가 있다면
            RequestDispatcher rd = request.getRequestDispatcher(nextPage);
            rd.forward(request, response); 
            // 5-3-1. 해당 페이지로 이동 (사용자에게 보여줌)
        }
    }
}