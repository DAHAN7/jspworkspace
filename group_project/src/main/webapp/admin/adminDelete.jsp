<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<s:query var="rs" dataSource="jdbc/MySQLDB">
    SELECT * FROM book_requests WHERE request_id = ?
    <s:param value="${param.request_id}" />
</s:query>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${rs.rows[0].title} 내용 삭제</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/requestBook/adDelete.css">
</head>
<body>
    <h1>${rs.rows[0].title} 내용 삭제</h1>
    <form action="adminDeleteSubmit.jsp" method="POST">
        <input type="hidden" name="request_id" value="${param.request_id}" />
        <table>
            <tr>
                <td>제목</td>
                <td>${rs.rows[0].title}</td>
            </tr>
            <tr>
                <td>저자</td>
                <td>${rs.rows[0].author}</td>
            </tr>
            <tr>
                <td>출판사</td>
                <td>${rs.rows[0].publisher}</td>
            </tr>
            <tr>
                <td>상태</td>
                <td>${rs.rows[0].status}</td>
            </tr>
            <tr>
                <td colspan="2"><button type="submit">삭제하기</button></td>
            </tr>
        </table>
    </form>
</body>
</html>
