<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%
	String userId = (String) session.getAttribute("userId");
%>
<s:update var="result" dataSource="jdbc/MySQLDB">
    INSERT INTO book_requests(memberId, title, author, publisher, year)
    VALUES (?, ?, ?, ?, ?)
    <s:param value="${userId}" />
    <s:param value="${param.title}" />
    <s:param value="${param.author}" />
    <s:param value="${param.publisher}" />
    <s:param value="${param.year}" />
</s:update>

<c:choose>
    <c:when test="${result >= 1}">
        <script>
            alert('신청 완료');
            location.href='bookBod.jsp';
        </script>
    </c:when>
    <c:otherwise>
        <script>
            alert('신청 실패');
            history.back();
        </script>
    </c:otherwise>
</c:choose>


