<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- 페이지 지시자: 자바 코드 사용, HTML 콘텐츠 유형, UTF-8 문자 인코딩 설정 --%>
<%-- sqlUpdateSubmit.jsp: 데이터베이스 업데이트 처리 JSP 파일 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 코어 태그 라이브러리: 조건문, 반복문 등 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 태그 라이브러리: 데이터베이스 쿼리 실행 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 설정 --%>
<title>update</title> <%-- 페이지 제목 --%>
</head>
<body>

	<%-- 예외 처리 시작 --%>
	<c:catch var="e"> 

		<%-- 데이터베이스 업데이트 쿼리 실행 --%>
		<s:update var="result" dataSource="java/MySQLDB"> <%-- update 태그: SQL UPDATE 쿼리 실행, 결과를 "result" 변수에 저장, 데이터 소스는 "java/MySQLDB" --%>
			UPDATE test_member SET pass = ?  <%-- test_member 테이블의 pass 컬럼 업데이트 --%>
			WHERE num = ? AND pass = ? <%-- num과 pass 조건에 맞는 행 업데이트 --%>
			<s:param>${param.newPass}</s:param> <%-- 첫 번째 ?에 새로운 비밀번호 바인딩 --%>
			<s:param>${param.num}</s:param> <%-- 두 번째 ?에 회원 번호 바인딩 --%>
			<s:param>${param.pass}</s:param> <%-- 세 번째 ?에 기존 비밀번호 바인딩 --%>
		</s:update>
		
		<%-- 업데이트 결과에 따른 처리 --%>
		<c:choose>
			<c:when test="${result == 1}"> <%-- 업데이트 성공 (1개 행 업데이트) --%>
				<c:redirect url="sqlQuery.jsp"/> <%-- sqlQuery.jsp 페이지로 리다이렉트 --%>
			</c:when>
			<c:otherwise> <%-- 업데이트 실패 (0개 행 업데이트 또는 조건 불일치) --%>
				<script>
					alert("잘못된 정보입니다. 확인 후 요청해주세요."); <%-- 오류 메시지 표시 --%>
					location.replace('sqlUpdate.jsp'); <%-- sqlUpdate.jsp 페이지로 이동 --%>
				</script>
			</c:otherwise>
		</c:choose>

	</c:catch> <%-- 예외 처리 종료 --%>

	<%-- 예외 발생 시 처리 --%>
	<c:if test="${!empty e}"> <%-- 예외 객체 "e"가 비어있지 않으면 (예외 발생) --%>
		<script>
			alert('회원정보 수정 실패'); <%-- 오류 메시지 표시 --%>
			history.go(-1); <%-- 이전 페이지로 이동 --%>
		</script>
	</c:if>
</body>
</html>
