<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- JSP 페이지 설정: 자바 언어 사용, 콘텐츠 유형은 HTML, 문자 인코딩은 UTF-8 --%>
<!DOCTYPE html> <%-- HTML5 문서임을 선언 --%>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 UTF-8 설정 (한글 처리) --%>
<title>includeTest.jsp</title> <%-- 페이지 제목 설정 --%>
</head>
<body>

	<% 
		// 요청 파라미터에서 "includePage" 값을 가져와 변수에 저장합니다.
		// 이 값은 포함할 페이지의 이름이 됩니다.
		String includePage = request.getParameter("includePage"); 
	%>


<h1>여기는 includeTest.jsp 입니다.</h1> <%-- 페이지 제목 표시 --%>
	<!-- 디렉티브 태그를 이용한 include -->
	<%-- <%@ include file="includePage.jsp" %> --%>
		<%-- 액션 태그를 이용한 include --%>
	<%-- 동적으로 includePage 변수에 지정된 JSP 페이지를 포함합니다. --%>
	<jsp:include page="<%=includePage%>"/> 

	<%-- 아래 부분은 주석 처리되어 실행되지 않습니다. --%>
	<%-- includePage.jsp에서 선언된 변수 s를 사용하려는 시도입니다. --%>
	<%-- <h2><%=s%></h2> --%> 

</body>
</html>
