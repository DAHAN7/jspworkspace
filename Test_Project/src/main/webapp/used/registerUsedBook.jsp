<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고책 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/used/style.css">
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
                <form id="registerBookForm" action="${pageContext.request.contextPath}/used/registerBook.jsp" method="POST" enctype="multipart/form-data">
                	<!-- 차후 중복 체크 추가-->
                	<div class="form-row">
                        <label for="book-title">제품등록 아이디:</label>
                        <input type="text" id="book-title" name="book_id" required>
                    </div>
                    <div class="form-row">
                        <label for="book-title">도서명:</label>
                        <input type="text" id="book-title" name="title" required>
                    </div>
                    <div class="form-row">
                        <label for="book-author">저자:</label>
                        <input type="text" id="book-author" name="author" required>
                    </div>
                    <div class="form-row">
                        <label for="book-publisher">출판사:</label>
                        <input type="text" id="book-publisher" name="publisher" required>
                    </div>
                    <div class="form-row">
                        <label for="book-memo">한줄 소개:</label>
                        <textarea id="book-memo" name="book_memo"></textarea>
                    </div>
                    <div class="form-row">
                        <label for="book-status">도서 상태:</label>
                        <input type="text" id="book-status" name="new_old_ebook" value="중고" readonly />
                    </div>
                    <div class="form-row">
                        <label for="book-price">판매 가격:</label>
                        <input type="number" id="book-price" name="price" min="1000" required> 원
                    </div>
                    <div class="form-row">
                        <label for="book-stock">입고 수량:</label>
                        <input type="number" id="book-stock" name="stock" min="1" required>
                    </div>
                    <div class="form-row">
                        <label for="book-category-overseas">국내/외 구분:</label>
                        <select id="book-category-overseas" name="category_overseas" required>
                            <option value="국내도서">국내</option>
                            <option value="해외도서">해외</option>
                        </select>
                    </div>
                    <div class="form-row">
                        <label for="book-category-age">연령대 구분:</label>
                        <select id="book-category-overseas" name="category_overseas" required>
                            <option value="10대">10대</option>
                            <option value="20대">20대</option>
                            <option value="30대">30대</option>
                            <option value="40대">40대</option>
                            <option value="50대+">50대+</option>
                        </select>
                       	
                    </div>
                    <div class="form-row">
                        <label for="book-category-all">대분류:</label>
                        <input type="text" id="book-category-all" name="category_all" value="${param.category_all}" readonly>
                    </div>
                    <div class="form-row">
                        <label for="book-images">사진 업로드:</label>
                        <input type="file" id="book-images" name="book_fileName" accept="image/*">
                    </div>
                    <input type="hidden" id="seller-id" name="seller_id" value="${sessionScope.memberNum}">
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
