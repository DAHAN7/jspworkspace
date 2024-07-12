<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%-- 페이지 지시어: JSP 페이지의 언어(Java), 콘텐츠 유형(HTML), 문자 인코딩(UTF-8)을 지정합니다. --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- 문자 집합 설정: HTML 문서의 문자 인코딩을 UTF-8로 설정하여 다양한 언어의 문자를 올바르게 표시할 수 있도록 합니다. --%>
<title>EXPRESSION LANGUAGE - 표현 언어</title>
<%-- 페이지 제목 설정: 웹 브라우저 탭에 표시될 페이지 제목을 설정합니다. --%>
</head>
<body>
	<!-- elTestForm.jsp -->
	<%--
        Expression Language (EL) 소개
        EL은 JSP 페이지에서 데이터 접근을 단순화하는 표현 언어입니다.
        4가지 영역 객체(page, request, session, application)와 파라미터 등의 데이터를 쉽게 사용할 수 있도록 지원합니다.
    --%>

	<%-- 각 영역 객체에 "scopeName" 속성을 다른 값으로 설정 --%>
	<%
	// pageContext.setAttribute("scopeName","page 영역"); // pageContext 영역에는 속성을 설정하지 않습니다.
	request.setAttribute("scopeName", "request 영역"); // request 영역에 "scopeName" 속성을 "request 영역" 값으로 설정합니다.
	session.setAttribute("scopeName", "session 영역"); // session 영역에 "scopeName" 속성을 "session 영역" 값으로 설정합니다.
	application.setAttribute("scopeName", "application 영역"); // application 영역에 "scopeName" 속성을 "application 영역" 값으로 설정합니다.
	%>
	<h3>영역객체에 저장된 속성 값 출력(사용)</h3>
	<%-- 제목: JSP 스크립트릿을 사용하여 각 영역 객체의 속성 값을 출력합니다. --%>
	page영역 :
	<%=pageContext.getAttribute("scopeName")%>
	<br />
	<%-- pageContext 영역의 "scopeName" 속성 값을 출력합니다. (null이 출력됨) --%>
	request영역 :
	<%=request.getAttribute("scopeName")%>
	<br />
	<%-- request 영역의 "scopeName" 속성 값을 출력합니다. --%>
	session영역 :
	<%=session.getAttribute("scopeName")%>
	<br />
	<%-- session 영역의 "scopeName" 속성 값을 출력합니다. --%>
	application영역 :
	<%=application.getAttribute("scopeName")%>
	<br />
	<%-- application 영역의 "scopeName" 속성 값을 출력합니다. --%>
	<hr />
	<%-- 수평선을 그어 위쪽 내용과 구분합니다. --%>
	<h3>EL 표현식 - \${영역객체.key}</h3>
	<%-- 제목: EL 표현식을 사용하여 각 영역 객체의 속성 값을 출력합니다. --%>
	pageEL : ${pageScope.scopeName}
	<br />
	<%-- page 영역의 "scopeName" 속성 값을 출력합니다. (null이 출력됨) --%>
	request EL : ${requestScope.scopeName}
	<br />
	<%-- request 영역의 "scopeName" 속성 값을 출력합니다. --%>
	session EL : ${sessionScope.scopeName}
	<br />
	<%-- session 영역의 "scopeName" 속성 값을 출력합니다. --%>
	application EL : ${applicationScope.scopeName}
	<br />
	<%-- application 영역의 "scopeName" 속성 값을 출력합니다. --%>
	<hr />
	EL scopeName : ${scopeName}
	<br />
	<%-- EL을 사용하여 "scopeName" 속성 값을 출력합니다. (가장 좁은 범위인 request 영역의 값이 출력됨) --%>

	<%--
    	EL에서 scopeName과 같이 영역을 명시하지 않으면, 
		pageContext   <  request   <  session  < application 순서로 검색하여 가장 먼저 찾은 값을 출력합니다.
 	--%>
	<%
	ServletRequest req = pageContext.getRequest(); // pageContext 객체를 통해 request 객체를 얻습니다.
	HttpSession ses = pageContext.getSession(); // pageContext 객체를 통해 session 객체를 얻습니다.
	ServletContext app = pageContext.getServletContext(); // pageContext 객체를 통해 application(ServletContext) 객체를 얻습니다.

	ses = request.getSession(); // request 객체를 통해 session 객체를 얻습니다. (동일한 session 객체를 참조합니다.)
	app = request.getServletContext(); // request 객체를 통해 application(ServletContext) 객체를 얻습니다. (동일한 application 객체를 참조합니다.)
	app = session.getServletContext(); // session 객체를 통해 application(ServletContext) 객체를 얻습니다. (동일한 application 객체를 참조합니다.)
	%>
	<%--
    pageContext.removeAttribute("scopeName"); // pageContext 영역의 "scopeName" 속성을 제거합니다. (주석 처리됨)
--%>
	<%
	Object obj = pageContext.findAttribute("scopeName"); // "scopeName" 속성을 모든 영역에서 검색하여 찾은 값을 obj 변수에 저장합니다.
	%>
	<%=obj%>
	<br />
	<%-- obj 변수의 값을 출력합니다. (request 영역의 "scopeName" 값이 출력됨) --%>
	<%-- findAttribute는 가장 좁은 범위부터 검색하므로 request 영역의 값이 출력됩니다. --%>
	pageEL : ${pageScope.scopeName}
	<br /> request EL : ${requestScope.scopeName}
	<br /> session EL : ${sessionScope.scopeName}
	<br /> application EL : ${applicationScope.scopeName}
	<br />
	<hr />
	<br />
	<form action="elTest.jsp" method="POST">
		<%-- elTest.jsp 페이지로 POST 방식으로 데이터를 전송하는 폼을 생성합니다. --%>
		<input type="text" name="id" />
		<%-- 사용자로부터 ID 값을 입력받는 텍스트 입력 필드를 생성합니다. --%>
		<button>확인</button>
		<%-- 폼 제출 버튼을 생성합니다. --%>
	</form>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
</body>
</html>



