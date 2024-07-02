<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="common/header.jsp" %><!-- common/header.jsp파일을 포함하여 헤더를 삽입 -->
	<article>
		<h1>MAIN 본문입니다.</h1><!-- 본문 제목 -->
		<h2><%=s%></h2><!-- s변수 출력,선언되지 않아서 에러 발생 가능 -->
		<%! String result = "본문에서 선언된 필드"; %><!-- JSP선언 태그로 필드 선언 -->
		<h3><%= result %></h3><!-- result필드 출력 -->
	</article>
<%@ include file="common/footer.jsp" %><!-- common/footer.jsp파일을 포함하여 푸터를 삽입 -->