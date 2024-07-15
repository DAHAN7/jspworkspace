a<%@ page language="java" contentType="text/html; charset=UTF-8" %><%-- 페이지 언어, 콘텐츠 유형, 문자 인코딩 설정 --%>
<!-- sqlResult.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL Core 태그 라이브러리 사용 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 태그 라이브러리 사용 --%>`
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- catch body 블럭 내부에서 예외가 발생하면 page 영역에 예외 객체를 e라는 이름으로 저장 -->
	<c:catch var="e">
		
		<s:setDataSource var="conn" 
			driver="com.mysql.cj.jdbc.Driver"  <%-- MySQL JDBC 드라이버 --%>
			url="jdbc:mysql://localhost:3306/digital_jsp"  <%-- 데이터베이스 연결 URL --%>
			user="digital" <%-- 데이터베이스 사용자 이름 --%>
			password="1234"/><%-- 데이터베이스 비밀번호 --%>
			
		<h3>${conn}</h3><%-- 데이터베이스 연결 정보 출력 (디버깅 용도) --%>
		<!-- insert, update, delete s:update -->
		<s:update var="result" dataSource="${conn}"> <%-- SQL UPDATE 쿼리 실행 (INSERT 문) --%>
			INSERT INTO test_member VALUES(null,?,?,?,?,?,?); <%-- SQL 쿼리 --%>
			<s:param>${param.id}</s:param> <%-- 폼에서 전달된 id 값을 쿼리에 바인딩 --%>
			<s:param>${param.pass}</s:param> <%-- 폼에서 전달된 pass 값을 쿼리에 바인딩 --%>
			<s:param>${param.addr}</s:param> <%-- 폼에서 전달된 addr 값을 쿼리에 바인딩 --%>
			<s:param>${param.phone}</s:param> <%-- 폼에서 전달된 phone 값을 쿼리에 바인딩 --%>
			<s:param>${param.gender}</s:param> <%-- 폼에서 전달된 gender 값을 쿼리에 바인딩 --%>
			<s:param>${param.age}</s:param> <%-- 폼에서 전달된 age 값을 쿼리에 바인딩 --%>
		</s:update>
		
		<c:if test="${result > 0}"> <%-- 쿼리 실행 결과가 1 이상이면 (INSERT 성공) --%>
			<h3>회원 등록 완료</h3>
		</c:if>
		
		<c:if test="${result == 0}"> <%-- 쿼리 실행 결과가 0이면 (INSERT 실패) --%>
			<h3>회원 등록 실패</h3>
		</c:if>
			
	</c:catch>
	
	<!-- e에 저장된 값이 존재하면 예외가 발생 -->
	<c:if test="${!empty e}"> <%-- 예외 객체 'e'가 비어있지 않으면 (예외 발생) --%>
		에러메세지 : <c:out value="${e.getMessage()}"/> <br/> <%-- 예외 메시지 출력 --%>
		<c:out value="${e.toString()}"/> <%-- 예외 정보 출력 --%>
	</c:if>
	<hr/>
	<a href="sqlQuery.jsp">member list</a> <%-- 회원 목록 페이지 링크 --%>
</body>
</html>





















