<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- loginSubmit.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginSubmit.jsp</title>
</head>
<body>
	<h1>Java Server Page</h1>
	<%
		// request 객체로부터 uid와 upw파라미터 값을 가져와 변수에 저장
		String uid = request.getParameter("uid");
		String upw = request.getParameter("upw");
	%>
	<!-- uid와 upw변수값을 브라우저에 출력 -->
	<%= uid %> <br/>
	<%= upw %> <br/>
	<!-- 메인페이지로 돌아가는 링크 -->
	<a href="index.html">메인으로</a>
</body>
</html>