<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- 페이지 지시자: 자바 코드 사용, HTML 콘텐츠 유형, UTF-8 문자 인코딩 설정 --%>
<%-- sqlDelete.jsp: 데이터베이스에서 회원 정보 삭제 처리 JSP 파일 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 코어 태그 라이브러리: 조건문 등 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 태그 라이브러리: 데이터베이스 쿼리 실행 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 설정 --%>
<title>회원 삭제</title> <%-- 페이지 제목 --%>
</head>
<body>

	<%-- 데이터베이스에서 회원 정보 삭제 --%>
	<s:update var="result" dataSource="java/MySQLDB"> <%-- update 태그: SQL DELETE 쿼리 실행, 결과를 "result" 변수에 저장, 데이터 소스는 "java/MySQLDB" --%>
		DELETE FROM test_member WHERE num = ? <%-- test_member 테이블에서 num 조건에 맞는 행 삭제 --%>
		<s:param>${param.num}</s:param> <%-- ?에 삭제할 회원 번호 바인딩 (이전 페이지에서 전달된 num 파라미터 사용) --%>
	</s:update>

	<%-- 삭제 결과에 따른 처리 --%>
	<c:if test="${result == 1}"> <%-- 삭제 성공 (1개 행 삭제) --%>
		<script>
			alert('정상적으로 처리가 완료 되었습니다.'); <%-- 성공 메시지 표시 --%>
			location.href='sqlQuery.jsp'; <%-- sqlQuery.jsp 페이지로 이동 --%>
		</script>
	</c:if>
	
	<c:if test="${result != 1}"> <%-- 삭제 실패 (0개 행 삭제 또는 오류) --%>
		<script>
			alert('처리가 실패 하였습니다.'); <%-- 실패 메시지 표시 --%>
			location.href='sqlQuery.jsp'; <%-- sqlQuery.jsp 페이지로 이동 --%>
		</script>
	</c:if>
</body>
</html>
