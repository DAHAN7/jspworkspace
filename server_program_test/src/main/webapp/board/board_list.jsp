<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>

<s:query var="result" dataSource="jdbc/MySQLDB">
	SELECT * FROM test_board ORDER BY board_num DESC
</s:query>
<!-- 별다른 페이지 요청이 없을 시 첫번째(1) page 목록 출력 -->
<%-- <c:set var="page" value="1" /> --%>

<!-- 파라미터로 전달된 page 번호가 존재하면 전달된 파라미터로 페이지 번호 지정 -->
<%-- 
<c:if test="${!empty param.page}">
	<c:set var="page" value="${param.page}"/>
</c:if>
 --%>
<!-- board/board_list.jsp?page=2 -->
<%-- ${page} <br/> --%>

<jsp:useBean id="cri" class="util.Criteria" scope="page"/>
<jsp:setProperty property="*" name="cri"/>

<%-- ${cri} <br/> --%>
<s:query var="result" dataSource="jdbc/MySQLDB" >
	SELECT * FROM test_board ORDER BY board_num DESC 
	limit ${cri.getStartRow()}, ${cri.getPerPageNum()} 
</s:query>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시글 목록</h1>
	<a href="${path}/board/board_write.jsp">게시글 작성하러 가기</a>
	<table border=1>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성시간</th>
			<th>조회수</th>
		</tr>
		<!-- 게시글 목록 -->
		<c:choose>
			<c:when test="${result.rowCount > 0}">
				<!-- 검색된 행이 존재 -->
				<c:forEach var="b" items="${result.rows}">
					<tr>
						<td>${b.board_num}</td>
						<td><a href="board_detail.jsp?board_num=${b.board_num}">${b.board_title}</a></td>
						<td>${b.board_name}</td>
						<td>${b.board_date}</td>
						<td>${b.board_readcount}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<!-- 검색된 행이 존재하지 않음 -->
				<tr>
					<td colspan="5">등록된 정보가 없습니다.</td>		
				</tr>	
			</c:otherwise>
		</c:choose>
	</table>
	<!-- 페이징 블럭 작성  -->
	<!-- test_board에 등록된 전체 게시글 행 개수 -->
	<s:query var="rs" 
		     dataSource="jdbc/MySQLDB" 
		     sql="SELECT count(*) as count FROM test_board" />
	
	<!-- PageMaker 객체 생성 -->	     
	<jsp:useBean id="pm" class="util.PageMaker"/>
	<jsp:setProperty property="cri" name="pm" value="${cri}"/>
	<jsp:setProperty property="displayPageNum" name="pm" value="10"/>
	<jsp:setProperty property="totalCount" name="pm" value="${rs.rows[0].count}"/>
	
	<%-- ${pm} <br/> --%>
    <hr/>
    <c:if test="${cri.page > 1}">
    	<a href="board_list.jsp?page=1">[처음]</a>
    	<c:if test="${pm.prev}">
    		<a href="board_list.jsp?page=${pm.startPage - 1}">[이전]</a>
    	</c:if>
    </c:if>
    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
    	<a href="board_list.jsp?page=${i}">[${i}]</a>
    </c:forEach>
    <c:if test="${cri.page < pm.maxPage}">
    	<c:if test="${pm.next}">
    		<a href="board_list.jsp?page=${pm.endPage + 1}">[다음]</a>
    	</c:if>
    	<a href="board_list.jsp?page=${pm.maxPage}">[마지막]</a>
    </c:if>
</body>
</html>




