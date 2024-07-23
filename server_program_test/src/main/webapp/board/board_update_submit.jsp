<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL Core 태그 라이브러리 사용 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 태그 라이브러리 사용 --%>

<%-- 게시글 수정 처리 --%>
<c:catch var="e"> <%-- 예외 발생 시 처리하기 위한 블록 --%>

	<s:update var="result" dataSource="jdbc/MySQLDB"> <%-- SQL UPDATE 쿼리 실행, 결과를 result 변수에 저장 --%>
		UPDATE test_board SET 
		board_name = ? , <%-- 게시글 작성자 이름 업데이트 --%>
		board_title = ? , <%-- 게시글 제목 업데이트 --%>
		board_content = ?  <%-- 게시글 내용 업데이트 --%>
		WHERE board_num = ${param.board_num} AND board_pass = ? <%-- 게시물 번호와 비밀번호 일치 조건 --%>
		<s:param>${param.board_name}</s:param> <%-- 작성자 이름 파라미터 설정 --%>
		<s:param>${param.board_title}</s:param> <%-- 제목 파라미터 설정 --%>
		<s:param>${param.board_content}</s:param> <%-- 내용 파라미터 설정 --%>
		<s:param>${param.board_pass}</s:param> <%-- 비밀번호 파라미터 설정 --%>
	</s:update>
	
	<%-- 게시글 수정 결과 처리 --%>
	<c:choose> <%-- 조건에 따른 분기 처리 --%>
		<c:when test="${result > 0}"> <%-- 수정 성공 시 (result 값이 0보다 크면) --%>
			<script>
				alert('수정완료'); <%-- 알림 메시지 표시 --%>
				location.href='board_detail.jsp?board_num=${param.board_num}'; <%-- 수정된 게시글 상세 페이지로 이동 --%>
			</script>
		</c:when>
		<c:otherwise> <%-- 수정 실패 시 --%>
			<script>
				alert('수정실패'); <%-- 알림 메시지 표시 --%>
				history.back(); <%-- 이전 페이지로 이동 --%>
			</script>
		</c:otherwise>
	</c:choose>
</c:catch>

<c:if test="${!empty e}"> <%-- 예외 발생 시 (e 변수가 비어있지 않으면) --%>
	<script>
		alert('정상적인 요청 처리를 할 수 없습니다.'); <%-- 알림 메시지 표시 --%>
		history.go(-1); <%-- 이전 페이지로 이동 --%> 
	</script>
</c:if>
