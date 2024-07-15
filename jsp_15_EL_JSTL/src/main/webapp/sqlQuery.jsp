<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%-- sqlQuery.jsp: 데이터베이스에서 회원 정보를 조회하고 결과를 표시하는 JSP 페이지 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL Core 태그 라이브러리 사용 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 태그 라이브러리 사용 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<s:setDataSource var="conn"  <%-- 데이터베이스 연결 정보 설정 --%>
		driver="com.mysql.cj.jdbc.Driver"  <%-- MySQL JDBC 드라이버 --%>
		url="jdbc:mysql://localhost:3306/digital_jsp" <%-- 데이터베이스 연결 URL --%>
		user="digital" <%-- 데이터베이스 사용자 이름 --%>
		password="1234"/> <%-- 데이터베이스 비밀번호 --%>

	<s:query var="rs" dataSource="${conn}" <%-- SQL 쿼리 실행 후 결과를 'rs' 변수에 저장 --%>
			sql="SELECT * FROM test_member ORDER BY num DESC"/> <%-- 모든 회원 정보를 num 역순으로 조회 --%>
	
	<%-- 아래 주석 처리된 부분은 위의 쿼리와 동일한 기능을 수행하는 다른 방식 --%>
<%-- 		 
	<s:query var="rs" dataSource="${conn}">
		SELECT * FROM test_member ORDER BY num DESC
	</s:query>
--%>
 <!-- rs.rowCount : 검색된 행의 개수 -->
 	<c:choose> <%-- 조회된 데이터 존재 여부에 따라 다른 내용 출력 --%>
		<c:when test="${rs.rowCount > 0}"> <%-- 조회된 행이 있으면 (rs.rowCount: 조회된 행 개수) --%>
			<h2>등록된 회원정보가 존재합 - ${rs.rowCount}</h2> <%-- 조회된 행 개수 출력 --%>
			<%-- 여기에 테이블 등을 사용하여 조회된 회원 정보를 표시하는 코드 추가 가능 --%>
		</c:when>
		<c:otherwise> <%-- 조회된 행이 없으면 --%>
			<h2>검색된 정보가 없습니다.</h2>
		</c:otherwise>
	</c:choose>
 
</body>
</html>














