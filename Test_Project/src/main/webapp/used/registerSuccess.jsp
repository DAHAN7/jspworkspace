<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String categoryOverseas = request.getParameter("category_overseas");
String categoryAll = request.getParameter("category_all");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서 등록 성공</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/used/style.css">
</head>
<body>
    <header class="header">
        <h1>중고샵</h1>
        <p>해외 직배송 도서 모음!</p>
    </header>

    <main>
        <div class="container">
            <section class="message">
                <h2>도서 등록 성공</h2>
                <p>축하합니다! 도서 등록이 성공적으로 완료되었습니다.</p>
                <a href="${pageContext.request.contextPath}/used/usedbooklist/UsedBookList.jsp?category_overseas=<%=categoryOverseas %>&category_all=<%=categoryAll%>" class="button">도서 목록 보기</a>
            </section>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024 중고샵. All rights reserved.</p>
    </footer>
</body>
</html>
