<%@ page language="java" contentType="text/html; charset=UTF-8"%><%-- JSP 페이지 설정: 자바 언어 사용, 콘텐츠 유형은 HTML, 문자 인코딩은 UTF-8 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- 문자 인코딩 UTF-8 설정 (한글 처리) --%>
<title>forwardTest2.jsp</title>
<%-- 페이지 제목 설정 --%>
</head>
<body>
	<%
	// 이전 페이지(forwardTest.jsp)에서 전달된 "nextPage" 파라미터 값 가져오기
	String nextPage = request.getParameter("nextPage");
	// nextPage 값을 콘솔에 출력 (디버깅 용도)
	System.out.println(nextPage);
	// 아래 코드는 주석 처리되어 실행되지 않습니다.
	// 만약 주석을 해제하면, RequestDispatcher를 사용하여 forwardTest1.jsp 페이지로 포워딩합니다.
	// forwardTest1.jsp
	/*
	RequestDispatcher rd = request.getRequestDispatcher(nextPage);
	rd.forward(request,response);
	*/
	%>
	<br>
	<%-- 줄 바꿈 --%>
	<hr>
	<%-- 수평선 추가 --%>
	<img>
	<%-- 이미지 태그 (src 속성 없으므로 이미지 표시 안됨) --%>
  <%-- 아래 코드는 주석 처리되어 실행되지 않습니다.
	     만약 주석을 해제하면, index.jsp 페이지로 포워딩합니다. --%>
	<%-- <jsp:forward page="index.jsp" /> --%>
	<%-- JSP 표준 액션 태그를 사용하여 nextPage 변수에 저장된 페이지로 포워딩 --%>
	<jsp:forward page="<%=nextPage%>">
	<%-- JSP 표준 액션 태그를 사용하여 nextPage 변수에 저장된 페이지로 포워딩 --%>
		<jsp:param value="01094867166" name="tel" />
	</jsp:forward>

</body>
</html>

