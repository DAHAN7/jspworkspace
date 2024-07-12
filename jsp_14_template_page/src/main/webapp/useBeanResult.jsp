<%@page import="test.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!-- useBeanResult.jsp -->
<%-- 
<%
	// 아래 부분은 주석 처리되어 실행되지 않습니다.
	// 요청 파라미터를 가져와 UserVO 객체를 생성하고 세션에 저장하는 스크립틀릿 코드입니다.
	/*
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String paramAge = request.getParameter("age");
	int age = Integer.parseInt(paramAge); // 문자열을 정수로 변환
	
	UserVO user = new UserVO(name, addr, age); // UserVO 객체 생성
	session.setAttribute("user", user); // 세션에 user 객체 저장
	*/
%>
 --%>
 <!-- useBean 활용 -->
<%
	// 아래 부분도 주석 처리되어 실행되지 않습니다.
	// 세션에서 UserVO 객체를 가져오고, 없으면 새로운 객체를 생성하여 세션에 저장하는 코드입니다.
	/*
	UserVO user = (UserVO)session.getAttribute("user");
	if(user == null){
		user = new UserVO();
		session.setAttribute("user", user);
	}
	*/
%>
<%-- JSP 표준 액션 태그 <jsp:useBean>을 사용하여 user 객체 생성 및 세션에 저장 --%>
<%-- 만약 세션에 user 객체가 이미 존재하면 해당 객체를 사용하고, 없으면 새로 생성합니다. --%>
<jsp:useBean id="user" class="test.UserVO" scope="session"/> 

<%-- JSP 표준 액션 태그 <jsp:setProperty>를 사용하여 user 객체의 속성 값 설정 --%>
<%-- property="*" 는 모든 요청 파라미터를 해당 이름과 일치하는 UserVO 객체의 속성에 자동으로 설정합니다. --%>
<jsp:setProperty name="user" property="*"/> 

<%-- 아래 부분은 주석 처리되어 실행되지 않습니다.
     만약 주석을 해제하면, <jsp:setProperty> 태그를 각각 사용하여 속성 값을 설정합니다. --%>
<%-- 
<jsp:setProperty name="user" property="name"/> 
<jsp:setProperty name="user" property="addr"/>
<jsp:setProperty name="user" property="age"/>
--%>
 
<%
	// 클라이언트를 "index.jsp" 페이지로 리다이렉트합니다.
	// 이때, 세션에 저장된 user 객체 정보도 함께 전달됩니다.
	response.sendRedirect("index.jsp");
%>

