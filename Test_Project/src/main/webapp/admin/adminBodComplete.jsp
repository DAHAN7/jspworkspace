<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>

<jsp:useBean id="cri" class="util.Criteria" scope="page"/>
<jsp:setProperty property="*" name="cri"/>
			    <% 
			    	int memberType = (Integer) session.getAttribute("memberType");
			    	if(memberType != 2){
			    %>
				    <script >
		    			location.href="../member/login.jsp"
				    </script>
				<%
			    	}
				%>
<s:query var="result" dataSource="jdbc/MySQLDB">
	SELECT * FROM book_requests WHERE status = '완료' ORDER BY request_id DESC
	limit ${cri.getStartRow()}, ${cri.getPerPageNum()}
</s:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 신청 목록</title>
   	<link rel="stylesheet" href="${pageContext.request.contextPath}/requestBook/bookBoard.css">
</head>
<body>
    <header>
        <h1>도서 신청 목록</h1>
        <nav>
        	<ul>
        		<li><a href="#"></a>홈</li>
        		<li><a href="#"></a>중고 사이트</li>
        		<li><a href="adminBod.jsp"></a>도서 신청</li>
        	</ul>
        </nav>
        <form action="reBookSearch.jsp" method="get" class="search-form">
        	<select name="op">
        		<option value="title">제목</option>
        		<option value="author">저자</option>
        		<option value="publisher">출판사</option>
        	</select>
            <input type="text" name="search" placeholder="도서 검색">
            <button type="submit">검색</button>
        </form>
    </header>
    
    <div class="container">
        <nav>
            <ul>
                <li><a href="adminBod.jsp">홈</a></li>
                <li><a href="adminBodApplying.jsp">승인</a></li>
                <li><a href="adminBodComplete.jsp">완료</a></li>
            </ul>
        </nav>
        
        <main class="content">
            <a href="reBook.jsp"><button class="request-button top">도서 신청</button></a>
            <table class="board-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>도서 제목</th>
                        <th>저자</th>
                        <th>출판사</th>
                        <th>출판 연도</th>
                        <th>상태</th>
                        <th>비고</th>
                    </tr>
                </thead>
                <tbody>
                   <c:choose>
                   	<c:when test="${result.rowCount > 0}">
                   		<c:forEach var="b" items="${result.rows}">
                   			<tr>
                   				<td>${b.request_id}</td>
                   				<td>${b.title}</td>
                   				<td>${b.author}</td>
                   				<td>${b.publisher}</td>
                   				<td>${b.year}</td>
                   				<td>${b.status }</td>
                   				<td>
                   					<a href="adminUpdate.jsp?request_id=${b.request_id}"><button>수정</button></a>
                   					<a href="adminDelete.jsp?request_id=${b.request_id}"><button>삭제</button></a>	
                   				</td>
                   			</tr>
                   		</c:forEach>
                   	</c:when>
                   	<c:otherwise>
                   		<tr>
                   			<td colspan="7">등록된 정보가 없습니다.</td>
                   		</tr>
                   	</c:otherwise>
                   </c:choose>
                </tbody>
                <tfoot>
                	<tr>
                		<td colspan="7">
                			<!-- 페이징 블록 -->
                			<s:query var="rs" dataSource="jdbc/MySQLDB">
                				SELECT count(*) as count FROM book_requests WHERE status = '완료'
                			</s:query>
							<jsp:useBean id="pm" class="util.PageMaker"/>
							<jsp:setProperty property="cri" name="pm" value="${cri}"/>
							<jsp:setProperty property="displayPageNum" name="pm" value="10"/>
							
                            <!-- Assume rs.rows[0].count has the total row count -->
							<jsp:setProperty property="totalCount" name="pm" value="${rs.rows[0].count}"/>
							
						    <c:if test="${cri.page > 1}">
						    	<a href="adminBodComplete.jsp?page=1"><input type="button" value="처음"/></a>
						    	<c:if test="${pm.prev}">
						    		<a href="adminBodComplete.jsp?page=${pm.startPage - 1}"><input type="button" value="이전"/></a>
						    	</c:if>
						    </c:if>
						    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
						    	<a href="adminBodComplete.jsp?page=${i}"><input type="button" value="${i}"/></a>
						    </c:forEach>
						    <c:if test="${cri.page < pm.maxPage}">
						    	<c:if test="${pm.next}">
						    		<a href="adminBodComplete.jsp?page=${pm.endPage + 1}"><input type="button" value="다음"/></a>
						    	</c:if>
						    	<a href="adminBodComplete.jsp?page=${pm.maxPage}"><input type="button" value="마지막"/></a>
						    </c:if>
                		</td>
                	</tr>
                </tfoot>
            </table>
        </main>
    </div>
    
    <footer>
        <p>&copy; 베스킨라빈스31.2</p>
    </footer>
</body>
</html>
