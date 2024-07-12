<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- JSP 페이지 설정: 자바 언어 사용, 콘텐츠 유형은 HTML, 문자 인코딩은 UTF-8 --%>
<!DOCTYPE html> <%-- HTML5 문서임을 선언 --%>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 UTF-8 설정 (한글 처리) --%>
<title>Action Tag</title> <%-- 페이지 제목 설정 --%>
</head>
<body>

	<%-- forwardTest.jsp 페이지로 이동하는 링크 생성 --%>
	<a href="forwardTest.jsp">forward Action tag</a> <br/>

	<%-- includeTest.jsp 페이지로 이동하는 링크 생성, includePage 파라미터에 includePage.jsp 값 전달 --%>
	<a href="includeTest.jsp?includePage=includePage.jsp"> include test 1 </a> <br/>

	<%-- includeTest.jsp 페이지로 이동하는 링크 생성, includePage 파라미터에 forwardTest.jsp 값 전달 --%>
	<a href="includeTest.jsp?includePage=forwardTest.jsp"> include test 2 </a> <br/>

</body>
</html>
