<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<s:update dataSource="jdbc/MySQLDB" var="result">
    UPDATE book_requests SET status = ?
    WHERE request_id = ?
    <s:param value="${param.status}" />
    <s:param value="${param.request_id}" />
</s:update>

	<!-- 게시글 수정 결과 처리 -->
<c:catch var="e">
	<c:choose>
		<c:when test="${result >= 1}">
			<script>
				alert('수정완료');
				location.href='adminBod.jsp';
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert('수정실패');
				history.back();
			</script>
		</c:otherwise>
	</c:choose>
</c:catch>
<c:if test="${!empty e}">
	<script>
		alert('정상적인 요청 처리를 할 수 없습니다.');
		history.go(-1); 
	</script>
</c:if>





























