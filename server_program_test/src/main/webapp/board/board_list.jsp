<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8, 페이지 인코딩 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 코어 라이브러리 사용, 접두사 'c' --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 라이브러리 사용, 접두사 's' --%>

<%-- 게시글 데이터 조회 (페이징 처리) --%>
<s:query var="result" dataSource="jdbc/MySQLDB">
	SELECT * FROM test_board ORDER BY board_num DESC 
	limit ${cri.getStartRow()}, ${cri.getPerPageNum()} <%-- 시작 행, 페이지당 게시물 수 설정 --%>
</s:query>

<%-- 페이징 처리를 위한 Criteria 객체 생성 및 설정 --%>
<jsp:useBean id="cri" class="util.Criteria" scope="page"/> <%-- Criteria 객체 생성 --%>
<jsp:setProperty property="*" name="cri"/> <%-- 요청 파라미터 값으로 Criteria 객체 속성 설정 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시글 목록</h1>
	<a href="${path}/board/board_write.jsp">게시글 작성하러 가기</a> <%-- 게시글 작성 페이지 링크 --%>

	<table border=1> <%-- 게시글 목록 테이블 --%>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성시간</th>
			<th>조회수</th>
		</tr>
		
		<%-- 게시글 목록 출력 (JSTL 반복문 사용) --%>
		<c:choose>
			<c:when test="${result.rowCount > 0}"> <%-- 게시글이 있는 경우 --%>
				<c:forEach var="b" items="${result.rows}"> <%-- 각 게시글에 대해 반복 --%>
					<tr>
						<td>${b.board_num}</td> <%-- 글번호 --%>
						<td><a href="board_detail.jsp?board_num=${b.board_num}">${b.board_title}</a></td> <%-- 제목 (링크) --%>
						<td>${b.board_name}</td> <%-- 작성자 --%>
						<td>${b.board_date}</td> <%-- 작성시간 --%>
						<td>${b.board_readcount}</td> <%-- 조회수 --%>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise> <%-- 게시글이 없는 경우 --%>
				<tr>
					<td colspan="5">등록된 정보가 없습니다.</td>		
				</tr>	
			</c:otherwise>
		</c:choose>
	</table>

	<%-- 페이징 처리 --%>
	<%-- 전체 게시글 수 조회 --%>
	<s:query var="rs" dataSource="jdbc/MySQLDB" sql="SELECT count(*) as count FROM test_board" />

	<%-- PageMaker 객체 생성 및 설정 --%>	     
	<jsp:useBean id="pm" class="util.PageMaker"/> <%-- PageMaker 객체 생성 --%>
	<jsp:setProperty property="cri" name="pm" value="${cri}"/> <%-- Criteria 객체 설정 --%>
	<jsp:setProperty property="displayPageNum" name="pm" value="10"/> <%-- 페이지 번호 표시 개수 설정 --%>
	<jsp:setProperty property="totalCount" name="pm" value="${rs.rows[0].count}"/> <%-- 전체 게시글 수 설정 --%>

	<hr/> <%-- 구분선 --%>

	<%-- 페이징 링크 출력 (JSTL 조건문, 반복문 사용) --%>
    <c:if test="${cri.page > 1}"> <%-- 현재 페이지가 1보다 큰 경우 --%>
    	<a href="board_list.jsp?page=1">[처음]</a> <%-- 첫 페이지 링크 --%>
    	<c:if test="${pm.prev}"> <%-- 이전 페이지 블록이 있는 경우 --%>
    		<a href="board_list.jsp?page=${pm.startPage - 1}">[이전]</a> <%-- 이전 페이지 블록 링크 --%>
    	</c:if>
    </c:if>
    
    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1"> <%-- 현재 페이지 블록의 페이지 번호 반복 --%>
    	<a href="board_list.jsp?page=${i}">[${i}]</a> <%-- 페이지 번호 링크 --%>
    </c:forEach>
    
    <c:if test="${cri.page < pm.maxPage}"> <%-- 현재 페이지가 마지막 페이지보다 작은 경우 --%>
    	<c:if test="${pm.next}"> <%-- 다음 페이지 블록이 있는 경우 --%>
    		<a href="board_list.jsp?page=${pm.endPage + 1}">[다음]</a> <%-- 다음 페이지 블록 링크 --%>
    	</c:if>
    	<a href="board_list.jsp?page=${pm.maxPage}">[마지막]</a> <%-- 마지막 페이지 링크 --%>
    </c:if>
</body>
</html>
