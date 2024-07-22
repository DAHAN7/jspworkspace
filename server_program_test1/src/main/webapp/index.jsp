<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="path" value="/" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // /board/board_list.jsp로 리디렉션
    response.sendRedirect(request.getContextPath() + "/board/board_list.jsp");
%>	
	<!-- redirect로 board/board_list.jsp 페이지 이동 -->
	<h3><a href="/board/board_list.jsp">게시판 목록</a></h3>
</body>
</html>





