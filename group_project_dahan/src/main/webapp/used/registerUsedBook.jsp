<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고책 등록</title>
    <link rel="stylesheet" href="/group_project/used/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <header class="header">
        <h1>중고책 등록</h1>
    </header>

    <main>
        <div class="container">
            <section class="insert-book">
                <h2>중고책 등록</h2>
                <form id="registerBookForm" action="registerBookServlet" method="POST" enctype="multipart/form-data">
                    <div class="form-row">
                        <label for="book-title">도서명:</label>
                        <input type="text" id="book-title" name="title" required readonly>
                    </div>
                    <div class="form-row">
                        <label for="book-author">저자:</label>
                        <input type="text" id="book-author" name="author" required readonly>
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
                    <input type="hidden" id="seller-id" name="seller_id" value="${sessionScope.sellerId}">
                    <button type="submit" class="submit-button">등록</button>
                </form>
            </section>
        </div>
    </main>

    <script>
        function registerBook(title, author) {
            $('#book-title').val(title);
            $('#book-author').val(author);
            $('html, body').animate({ scrollTop: $('#registerBookForm').offset().top }, 'slow');
        }

        $('#registerBookForm').submit(function(event) {
            if (!confirm('중고책을 등록하시겠습니까?')) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>
