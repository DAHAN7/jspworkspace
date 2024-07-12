<%@ page language="java" contentType="text/html; charset=UTF-8" %><%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- JSP 페이지 설정: 자바 언어 사용, 콘텐츠 유형은 HTML, 문자 인코딩은 UTF-8 --%>
<!DOCTYPE html> <%-- HTML5 문서임을 선언 --%>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 UTF-8 설정 (한글 처리) --%>
<title>forwardTest1.jsp</title> <%-- 페이지 제목 설정 --%>
</head>
<body>
	<h1>출력된 페이지(forwardTest1.jsp)</h1> <%-- 페이지 제목 표시 --%>
	<%-- 사용자 정보 출력 테이블 --%>
	<!-- table>(tr>td*2)*4 -->
	<table border=1> <%-- 테이블 생성, 테두리 설정 --%>
		<tr><%-- 테이블 행 시작 --%>
			<td>이름</td><%-- 테이블 셀 (헤더) --%>
			<%-- 이전 페이지에서 전달받은 "name" 파라미터 값을 출력 --%>
			<td><%= request.getParameter("name") %></td>
		</tr>
		<tr>
			<td>나이</td>
			<td><%= request.getParameter("age") %></td><%-- "age" 파라미터 값 출력 --%>
		</tr>
		</tr>
		<tr>
			<td>주소</td>
			<td><%= request.getParameter("addr") %></td> <%-- "addr" 파라미터 값 출력 --%>
		</tr>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%= request.getParameter("tel") %></td>
			<%-- "tel" 파라미터 값 출력 (이전 페이지에서 전달되지 않았을 경우 null 출력) --%>
		</tr>
	</table>
</body>
</html>



