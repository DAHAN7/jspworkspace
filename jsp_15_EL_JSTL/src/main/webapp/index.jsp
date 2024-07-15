<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%-- 페이지 지시어(Directive): JSP 페이지를 처리하는 방법에 대한 지침을 JSP 컨테이너에 제공합니다. 여기서는 페이지의 언어(Java), 콘텐츠 유형(HTML), 문자 인코딩(UTF-8)을 지정합니다. --%>

<!DOCTYPE html>
<%-- 문서 유형 선언: 이 HTML 문서가 HTML5 표준을 따름을 나타냅니다. --%>
<html>
<head>
<meta charset="UTF-8">
<%-- 문자 집합 설정: HTML 문서의 문자 인코딩을 UTF-8로 설정하여 다양한 언어의 문자를 올바르게 표시할 수 있도록 합니다. --%>
<title>webapp/index.jsp</title>
<%-- 페이지 제목 설정: 웹 브라우저 탭에 표시될 페이지 제목을 설정합니다. --%>
</head>
<body>
	<h1>EL &amp; JSTL</h1>
	<%-- 페이지의 주요 제목을 나타내는 H1 태그입니다. EL(Expression Language)과 JSTL(JSP Standard Tag Library)에 대한 페이지임을 명시합니다. --%>
	<a href="elTestForm.jsp">EL TEST</a>
	<br />
	<%-- "elTestForm.jsp" 페이지로 연결되는 하이퍼링크를 생성합니다. 사용자가 클릭하면 해당 페이지로 이동합니다. --%>
	<a href="jstlCore.jsp">JSTL core</a>
	<br />
	<%-- "jstlCore.jsp" 페이지로 연결되는 하이퍼링크를 생성합니다. 사용자가 클릭하면 해당 페이지로 이동합니다. --%>
	<a href="jstlCoreControl.jsp">JSTL Control core</a>
	<br />
	<a href="jstlFmtForm.jsp">JSTL formatter</a> <br/>
	<a href="jstlSQL.jsp">JSTL SQL</a> <br/>
	<a href="sqlQuery.jsp">JSTL SQL Query</a> <br/>
</body>
</html>