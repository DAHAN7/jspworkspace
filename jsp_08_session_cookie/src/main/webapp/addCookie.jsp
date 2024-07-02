<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<hr/>
	<h1>ADD COOKIE</h1>
	<hr/>
	<%
		/*
			Max-Age 는 초단위
			60 * 60 * 24 * 30 
		*/
		// response.addHeader("Set-Cookie","id=id001; Max-Age=2592000; path=/");
		
	
		// 2번째 방법
		Cookie cookie = new Cookie("PM_NAME", "최기근");//"PM_NAME"이라는 이름의 쿠키를 생성하고,값은 "최기근"으로 설정
		cookie.setMaxAge(2592000);//쿠키의 유효기간을 2592000초(30일)로 설정
		cookie.setPath("/");// 쿠키의 경로를 루트("/")로 설정
		response.addCookie(cookie);//응답에 쿠키를 추가
	%>
	<!-- 메인 페이지로 이동하는 링크 -->
	<a href="index.jsp">메인으로</a>
</body>
</html>