<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>중고서적 상세보기</title>
    <style>
        .book-detail {
            margin: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            max-width: 600px;
            margin: auto;
        }
        .book-detail img {
            max-width: 100%;
            height: auto;
        }
        .book-detail h1 {
            font-size: 24px;
            margin: 0 0 10px;
        }
        .book-detail p {
            font-size: 16px;
            margin: 5px 0;
        }
        .book-detail a {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
        }
        .book-detail a:hover {
            background-color: #0056b3;
        }
        .navigation-links {
            margin-top: 20px;
        }
        .navigation-links a {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <h1>중고서적 상세보기</h1>

    <!-- 책 세부정보 조회 -->
    <sql:query var="bookDetail" dataSource="jdbc/baskin">
        SELECT b.title, b.author, b.publisher, b.price, b.image_path, b.description, b.category, b.stock, b.status
        FROM Books b
        WHERE b.book_id = ?
        <sql:param value="${param.bookId}" />
    </sql:query>

    <c:choose>
        <c:when test="${not empty bookDetail.rows}">
            <c:set var="book" value="${bookDetail.rows[0]}" />
            <div class="book-detail">
                <img src="${book.image_path != null ? book.image_path : 'default_image.jpg'}" alt="${book.title}">
                <h1>${book.title}</h1>
                <p>저자: ${book.author}</p>
                <p>출판사: ${book.publisher}</p>
                <p>가격: ${book.price}원</p>
                <p>상태: ${book.status}</p>
                <p>카테고리: ${book.category}</p>
                <p>재고: ${book.stock}권</p>
                <p>${book.description}</p>
                <div class="navigation-links">
                    <a href="${param.referer}">목록으로 돌아가기</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <p>책 정보를 찾을 수 없습니다.</p>
            <div class="navigation-links">
                <a href="${param.referer}">목록으로 돌아가기</a>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
