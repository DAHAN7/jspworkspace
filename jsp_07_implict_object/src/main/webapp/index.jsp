<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index jsp</title>
</head>
<body>
	<!-- 링크를 포함하는 제목  -->
	<h3>
	<!-- "requestTest.jsp페이지로 이동하는 링크 -->
		<a href="request/requestTest.jsp">request method 확인</a>
	</h3>
	<!-- 
		속성-영역 객체
		pageContext		< 		request		<		session		< 		application
		하나의 jsp page	하나의 요청에 대한 응답이	  브라우저가 종료 될때 까지		서버가 종료될 때 까지
						완료 될때까지 유지 
	 -->
	<h3>
		<!-- "attrForm.jsp"페이지로 이동하는 링크 -->
		<a href="attrForm.jsp">속성-영역 객체 테스트</a>
	</h3>
	<!-- pageContext영역에 저장된 "pageId"속성값을 출력 -->
	<h4>pageContext id : <%= pageContext.getAttribute("pageId") %></h4>
	<!-- request영역에 저장된 "requestEmail"속성값을 출력 -->
	<h4>request email : <%= request.getAttribute("requestEmail") %></h4>
	<!-- session영역에 저장된 "sessionEmail"속성값을 출력 -->
	<h4>session email : <%= session.getAttribute("sessionEmail") %></h4>
	<!-- applicaiton 영역에 저장된 "appId"속성값을 출력 -->
	<h4>application id : <%= application.getAttribute("appId") %></h4>
</body>
</html>





