<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서 등록 실패</title>
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
                <h2>도서 등록 실패</h2>
                <p>죄송합니다. 도서 등록에 실패했습니다. 다시 시도해 주세요.</p>
                <a href="javascript:history.back();" class="button">다시 시도하기</a>
            </section>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024 중고샵. All rights reserved.</p>
    </footer>
</body>
</html>
