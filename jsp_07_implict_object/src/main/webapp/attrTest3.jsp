<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>attrTest3.jsp</title>
</head>
<body>
	<!-- 페이지 제목 -->
	<h1>attrTest3.jsp Page</h1>
	<!-- pageContext 영역에 저장된 "pageId"속성값을 출력 -->
	<h4>pageContext id : <%= pageContext.getAttribute("pageId") %></h4>
	<!-- request영역에 저장된 "requestEmail"속성 값을 출력 -->
	<h4>request email : <%= request.getAttribute("requestEmail") %></h4>
	<!-- session 영역에 저장된 "sessionEmail"속성 값을 출력 -->
	<h4>session email : <%= session.getAttribute("sessionEmail") %></h4>
	<!-- applicaition 영역에 저장된 "appId"속성 값을 출력 -->
	<h4>application id : <%= application.getAttribute("appId") %></h4>
	<!-- 메인 페이지(index.jsp)로 이동하는 링크 -->
	<a href="index.jsp">메인으로</a>
</body>
</html>








