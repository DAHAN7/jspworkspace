package util;

import jakarta.servlet.http.HttpServletRequest;

// 다양한 유틸리티 메서드를 제공하기 위한 인터페이스
public interface FactoryUtil {

    /**
     * 요청 정보에서 특정 명령어(구분 문자열)를 추출하여 반환하는 메서드
     * 
     * @param request - 클라이언트로부터의 요청 정보가 담긴 HttpServletRequest 객체
     * @return String - 전체 요청 URI에서 컨텍스트 경로를 제외한 나머지 부분을 반환 (주로 요청에 따른 명령어를 추출하기 위해 사용)
     */
    public static String getCommand(HttpServletRequest request) {
        // 요청 URI에서 컨텍스트 경로의 길이를 제외한 부분을 잘라서 반환
        return request.getRequestURI().substring(request.getContextPath().length() + 1);
    }
    
}
