<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고책 등록</title>
    <link rel="stylesheet" href="/test/used/style.css">
    <script src="/test/used/script.js"></script>
</head>
<body>
    <header class="header">
        <h1>중고책 등록</h1>
    </header>

    <main>
        <div class="container">
            <!-- 중고책 등록 폼 -->
            <section class="insert-book">
                <h2>중고책 등록</h2>
                <form id="bookForm" action="insertUsedBook.jsp" method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <label for="book-title">도서명:</label>
                        <input type="text" id="book-title" name="title" required>
                    </div>
                    <div class="form-row">
                        <label for="book-author">저자:</label>
                        <input type="text" id="book-author" name="author" required>
                    </div>
                    <div class="form-row">
                        <label for="book-price">판매 가격:</label>
                        <input type="number" id="book-price" name="price" min="1000" required> 원
                    </div>
                    <div class="form-row">
                        <label for="book-condition">도서 상태:</label>
                        <select id="book-condition" name="condition" required>
                            <option value="best">최상</option>
                            <option value="good">상</option>
                            <option value="fair">중</option>
                            <option value="poor">하</option>
                        </select>
                    </div>
                    <div class="form-row">
                        <label for="book-description">상세 설명:</label>
                        <textarea id="book-description" name="description"></textarea>
                    </div>
                    <div class="form-row">
                        <label for="book-images">사진 업로드:</label>
                        <input type="file" id="book-images" name="image" multiple accept="image/*">
                    </div>
                    <!-- seller_id를 포함하는 숨은 입력 필드 추가 -->
                    <input type="hidden" id="seller-id" name="seller_id" value="${sessionScope.sellerId}">
                    <button type="submit" class="submit-button">등록</button>
                </form>
            </section>
        </div>
    </main>

    <script>
        document.getElementById('bookForm').addEventListener('submit', function(event) {
            event.preventDefault();
            if (confirm('중고책을 등록하시겠습니까?')) {
                this.submit();
            }
        });
    </script>
</body>
</html>
