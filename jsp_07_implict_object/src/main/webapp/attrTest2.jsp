<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>attrTest2.jsp</title>
</head>
<body>
	<%
		// request 객체로부터 "email"파라미터 값을 가져옵니다.
		String email = request.getParameter("email");
	
		// 새로 생성된 요청에는 id 가 포함되어 있지 않음.
		String id = request.getParameter("id"); 
		// request 객체에 "requestEmail"이라는 이름으로 email값을 저장합니다.
		request.setAttribute("requestEmail", email);
		//session 객체에 "sessionEmail"이라는 이름으로 email값을 저장합니다.
		session.setAttribute("sessionEmail" , email);
		
	%>
	<!-- 요청으로 전달된 "id"와 "email"값을 출력합니다. -->
	<h3>request param id : <%= id %></h3>
	<h3>request param email : <%= email %></h3>
	<hr/>
	<!-- 각 영역 객체에 저장된 값을 출력합니다. -->
	<h4>pageContext id : <%= pageContext.getAttribute("pageId") %></h4>
	<h4>request email : <%= request.getAttribute("requestEmail") %></h4>
	<h4>session email : <%= session.getAttribute("sessionEmail") %></h4>
	<h4>application id : <%= application.getAttribute("appId") %></h4>
	<hr/>
	<!-- 새로운 요청을 위한 링크 -->
	<h4><a href="attrTest3.jsp">새로운 요청 시 확인</a></h4>
</body>
</html>















