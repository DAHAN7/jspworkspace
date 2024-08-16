package service;

import dao.MemberDAO;
import dao.MemberDAOImpl;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vo.MemberVO;

public class MemberServiceImpl implements MemberService { 
    // 2. 서비스 시작! (회원 관리 기능 제공)

    MemberDAO dao = new MemberDAOImpl(); 
    // 3. 데이터베이스 담당자(DAO)에게 일 시키기

    // 4. 회원가입 기능
    @Override
    public boolean memberJoin(HttpServletRequest request) { 
        // 4-1. 사용자가 입력한 정보 가져오기
        String id = request.getParameter("id");
        String pass = request.getParameter("pass");
        String name = request.getParameter("name");

        // 4-2. 사용자 정보를 MemberVO 객체에 담기
        MemberVO member = new MemberVO(id, pass, name);

        // 4-3. 데이터베이스 담당자에게 회원가입 처리 시키고 결과 받기
        return dao.memberJoin(member); 
    }

    // 5. 로그인 기능
    @Override
    public boolean memberLogin(HttpServletRequest request, HttpServletResponse response) {
        // 5-1. 사용자가 입력한 정보 가져오기
        String id = request.getParameter("id");
        String pass = request.getParameter("pass");

        // 5-2. 데이터베이스 담당자에게 로그인 처리 시키고 결과(사용자 정보) 받기
        MemberVO member = dao.memberLogin(id, pass);

        if (member != null) { 
            // 5-3. 로그인 성공!
            HttpSession session = request.getSession();
            session.setAttribute("member", member); 
            // 5-3-1. 사용자 정보를 "member"라는 이름으로 세션에 저장 (로그인 상태 유지)

            String check = request.getParameter("check");
            if (check != null) { 
                // 5-3-2. "로그인 상태 유지" 체크박스를 선택했다면
                Cookie cookie = new Cookie("id", id);
                cookie.setMaxAge(60 * 60 * 24 * 15); // 5-3-2-1. 15일 동안 쿠키 유지 설정
                cookie.setPath("/"); 
                response.addCookie(cookie); 
                // 5-3-2-2. "id"라는 이름으로 사용자 ID를 쿠키에 저장 (자동 로그인)
            }
            return true; // 5-3-3. 로그인 성공했음을 알림
        }
        return false; // 5-4. 로그인 실패했음을 알림
    }

    // 6. 로그아웃 기능
    @Override
    public void logOut(HttpServletRequest request, HttpServletResponse response) {
        // 6-1. 세션에서 "member" 정보 제거 (로그인 상태 해제)
        HttpSession session = request.getSession();
        session.removeAttribute("member");
        // session.invalidate(); // 전체 세션 무효화 (필요한 경우 사용)

        // 6-2. 쿠키에서 "id" 정보 제거 (자동 로그인 해제)
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("id")) {
                    Cookie cookie = new Cookie("id", "");
                    cookie.setMaxAge(0); // 6-2-1. 쿠키 즉시 만료 설정
                    cookie.setPath("/");
                    response.addCookie(cookie); 
                    // 6-2-2. "id" 쿠키를 빈 값으로 덮어쓰고 만료시킴
                    break; 
                }
            }
        }
    }
}