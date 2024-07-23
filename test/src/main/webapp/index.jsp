<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="path" value="/" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고서적 </title>
</head>
<body>
	<!-- redirect로 /used/used_books.html 페이지 이동 -->
	<c:redirect url="/used/used_books.html"/>
	<%-- 
	<%
		response.sendRedirect("/used/used_books.html");
	%>
	 --%>
</body>
</html>
