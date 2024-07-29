<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<!-- checkId.jsp -->    
<!-- ID 중복 체크 -->
<c:catch var="e">
	<!-- db연결 -->
	<s:setDataSource var="conn"
					 driver="com.mysql.cj.jdbc.Driver" 
					 url="jdbc:mysql://localhost:3306/baskin" 
					 user="root" 
					 password="1234"/>
	<!-- 쿼리문작성 -->				 
	<s:query var="rs" dataSource="${conn}" >
		SELECT * FROM books WHERE book_id = ? 
		<s:param>${param.book_id}</s:param>
	</s:query> 
	
	<c:choose>
		<c:when test="${rs.rowCount > 0}">
			<!-- 동일한 아이디 존재 -->
			<script>
				alert('이미 사용중인 book id 입니다.');
			</script>
		</c:when>
		<c:otherwise>
			<!-- 동일한 아이디 존재하지 않음 -->
			<script>
				alert('사용 가능한 book id 입니다.');
			</script>
		</c:otherwise>
	</c:choose>
	
	<script>
		history.go(-1);
	</script>	
					 
</c:catch>					 