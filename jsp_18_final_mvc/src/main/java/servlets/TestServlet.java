package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// TestServlet 클래스는 HttpServlet을 상속받아 HTTP 요청을 처리
public class TestServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    // GET 요청을 처리하는 메서드
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 콘솔에 메시지 출력
        System.out.println("test test1 GET 요청");
        
        // 요청 URI 가져오기
        String requestPath = request.getRequestURI();
        // 예: /jsp_18_final_mvc/test1?test=hello
        System.out.println("전체 요청 경로 : " + requestPath);
        
        // 프로젝트의 컨텍스트 경로 가져오기
        String contextPath = request.getContextPath();
        // 예: /jsp_18_final_mvc
        System.out.println("요청 프로젝트 경로 : " + contextPath);
        
        // 요청 URI에서 컨텍스트 경로를 제외한 부분 추출
        String command = requestPath.substring(contextPath.length() + 1);
        // 예: test1?test=hello
        System.out.println("요청 URL : " + command);
        
        // 요청 경로에 따라 request 객체에 속성 설정
        if(requestPath.equals("/jsp_18_final_mvc/test")) {
            // 요청 경로가 /jsp_18_final_mvc/test인 경우
            request.setAttribute("test", "Test Param");
        } else {
            // 그 외의 경우, 요청 파라미터에서 'test' 값을 가져와 설정
            String test = request.getParameter("test");
            request.setAttribute("test", test);
        }
        
        // 요청을 /common/main.jsp로 포워딩
        RequestDispatcher rd = request.getRequestDispatcher("/common/main.jsp");
        rd.forward(request, response);
        
        /*
        // response 객체를 사용하여 직접 응답을 작성할 수도 있음 (현재는 주석 처리)
        PrintWriter out = response.getWriter();
        out.println("<h1>Hello Everyone</h1>");
        */
    }
}
