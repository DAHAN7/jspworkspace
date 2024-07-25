<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고책 등록</title>
    <link rel="stylesheet" href="/test/used/style.css">
    <script src="/test/used/script.js" defer></script>
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
                <form id="bookForm" action="registerUsedBookResult.jsp" method="post" enctype="multipart/form-data">
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
                        <label for="book-status">도서 상태:</label>
                        <select id="book-status" name="status" required>
                            <option value="신책">신책</option>
                            <option value="중고책">중고책</option>
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
            if (!confirm('중고책을 등록하시겠습니까?')) {
                event.preventDefault(); // 사용자가 취소하면 폼 제출을 막습니다.
            }
        });
    </script>
</body>
</html>
