<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
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
<s:query var="rs" dataSource="jdbc/MySQLDB">
    SELECT title, author, publisher, year, status FROM book_requests 
    WHERE request_id = ${param.request_id}
</s:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/requestBook/adUpdate.css">
</head>
<body>
    <h1>관리자 페이지</h1>
    <div class="container">
        <div class="content">
            <h2>신규 도서 신청</h2>
            <form action="adminUpdateSubmit.jsp" method="post">
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
                        <td>출판 년도</td>
                        <td>${rs.rows[0].year}</td>
                    </tr>
                    <tr>
                        <td>상태</td>
                        <td>
                            <input type="radio" name="status" value="신청" ${rs.rows[0].status == '신청' ? 'checked' : ''}/> 신청
                            <input type="radio" name="status" value="승인" ${rs.rows[0].status == '승인' ? 'checked' : ''}/> 승인
                            <input type="radio" name="status" value="완료" ${rs.rows[0].status == '완료' ? 'checked' : ''}/> 완료
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><button type="submit">수정완료</button></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
    <footer class="footer">
        <p>&copy; 배스킨라빈스31.2</p>
    </footer>
</body>
</html>
