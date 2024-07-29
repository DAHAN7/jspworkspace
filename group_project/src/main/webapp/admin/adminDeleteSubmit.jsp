<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>

<!-- 게시글 삭제 요청 처리 -->
<s:update var="result" dataSource="jdbc/MySQLDB">
	DELETE FROM book_requests
	WHERE request_id = ? AND status = '완료'
	<s:param value="${param.request_id}" />
</s:update>

<!-- 게시글 삭제 요청 결과 처리 -->
<c:choose>
	<c:when test="${result >= 1}">
		<script>
			alert('삭제 완료');
			location.href='adminBod.jsp';
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert('삭제 실패');
			history.back();
		</script>
	</c:otherwise>
</c:choose>














    
>>>>>>> 6543a2e1e9e7d98afb5ee2bcb91ee474797d48d7
