<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="test.UserVO" %>
<!-- useBean.jsp -->
<h1>Beans Test</h1>
<%-- 아래 부분은 주석 처리되어 실행되지 않습니다. --%>
	<%-- UserVO 객체를 생성하고 세션에 저장하는 스크립틀릿 코드 --%>
	<%-- 
	<%
	UserVO user = new UserVO();
	session.setAttribute("user",user);
	
	user.setName("최기근");
	user.setAddr("부산");
	user.setAge(26);
	%>
	--%>

	<%-- JSP 표준 액션 태그 <jsp:useBean>을 사용하여 user 객체 생성 및 세션에 저장 --%>
	<jsp:useBean id="user" class="test.UserVO" scope="session"/> 

	<%-- JSP 표준 액션 태그 <jsp:setProperty>를 사용하여 user 객체의 속성 값 설정 --%>
	<jsp:setProperty name="user" property="name" value="김동하"/>
	<jsp:setProperty name="user" property="addr" value="평양"/>
	<jsp:setProperty name="user" property="age" value="26"/>

	<%-- user 객체의 속성 값 출력 --%>
	<h3><%=user.getName()%></h3>
	<h3><%=user.getAddr()%></h3>
	<h3><%=user.getAge()%></h3>

	<%-- 다양한 scope (page, request, session, application)로 UserVO 객체 생성 --%>
	<jsp:useBean id="aaa" class="test.UserVO" scope="page"/> <%-- 페이지 범위 --%>
	<jsp:useBean id="bbb" class="test.UserVO" scope="request"/> <%-- 요청 범위 --%>
	<jsp:useBean id="ccc" class="test.UserVO" scope="session"/> <%-- 세션 범위 --%>
	<jsp:useBean id="ddd" class="test.UserVO" scope="application"/> <%-- 애플리케이션 범위 --%>

	<% 
		// 각 scope에 저장된 UserVO 객체 가져와서 출력 
		UserVO a = (UserVO)pageContext.getAttribute("aaa");
		out.println(a);
		out.println("<hr/>");
		UserVO b = (UserVO)request.getAttribute("bbb");
		out.println(b);
		out.println("<hr/>");
		UserVO c = (UserVO)session.getAttribute("ccc");
		out.println(c);
		out.println("<hr/>");
		UserVO d = (UserVO)application.getAttribute("ddd");
		out.println(d);
		out.println("<hr/>");

        // application 범위에서 aaa 객체 가져오기 시도 (실패 - aaa는 page 범위)
		UserVO test = (UserVO)application.getAttribute("aaa");
		out.println(test); 
		out.println("<hr/>");
	%>

	<%-- 아래 부분은 주석 처리되어 실행되지 않습니다. --%>
	<%-- id 속성에 부여된 변수 이름 중복 (ddd 이미 사용됨) --%>
	<%-- <jsp:useBean id="ddd" class="test.UserVO" scope="application"/> --%>

	<%-- JSP 표준 액션 태그 <jsp:getProperty>를 사용하여 user 객체의 속성 값 출력 --%>
	<h3><jsp:getProperty name="user" property="name"/></h3>
	<h3><jsp:getProperty name="user" property="addr"/></h3>
	<h3><jsp:getProperty name="user" property="age"/></h3>