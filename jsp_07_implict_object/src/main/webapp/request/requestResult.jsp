<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request/requestResult.jsp</title>
</head>
<body>
	<!-- 스크립틀릿 태그 -->
	<%
		// 요청 시 호출 되는 _jspService method내부에 작성되는 태그
		
		// request 로 전달된 data(parameter)를 처리할 문자셋 정보 확인
		String encoding = request.getCharacterEncoding();
		// 응답 객체를 통해서 출력 할 스트림 정보를 저장한 내장객체
		out.println("encoding : " + encoding +"<br/>");
		
		// 요청 시 전달된 파라미터 값 확인
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String[] hobbies = request.getParameterValues("hobbies");
		// 성별 파라미터가 존재할 경우,성별 값을 변환하여 저장
		if(gender != null){
			gender = (gender.equals("male")) ? "남성"  : "여성";
		}
		// 각 파라미터 값을 출력
		out.println("name : " + name +"<br/>");
		out.println("gender : " + gender +"<br/>");
		out.println("hobbies : " + Arrays.toString(hobbies) +"<br/>");
		
		// 요청한 client 원격지 아이피 주소
		String ip = request.getRemoteAddr();
		out.println("ip : " + ip +"<br/>");
		
		// 요청이 전달된 사용자의 요청 전송 방식, GET or POST
		String method = request.getMethod();
		out.println("요청 전송 방식 : " + method +"<br/>");
		
		// contextPath  
		// WAS(Web Application Server)에서 
		// wepApp을 구분하기 위한 경로(path)
		String contextPath = request.getContextPath();
		out.println("contextPath : " + contextPath + "<br/>");
		
		// 요청 경로 - 현재 서버의 프로젝트별 전체 요청 경로
		String requestURI = request.getRequestURI();
		out.println("requestURI : " + requestURI + "<br/>");
		// 문자열 결합 예시
		String str = "text";
		str += " append";
		str += " result";
		
		// 전체 요청 경로 - URL
		StringBuffer requestURL = request.getRequestURL();
		out.println("requestURL : " + requestURL + "<br/>");
		
		// get 방식으로 전달된 파라미터 정보
		String queryString = request.getQueryString();
		out.println("queryString : " + queryString + "<br/>");
		
		// 요청 시 전달된 contentType
		String contentType = request.getContentType();
		out.println("contentType : " + contentType + "<br/>");
		
	%>
</body>
</html>