<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="used.Book" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 목록</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>도서 목록</h1>

    <div class="book-list">
        <% 
        List<Book> books = (List<Book>) request.getAttribute("books");
        if (books != null) {
            for (Book book : books) {
        %>
        <div class="book-item">
            <a href="<%= book.getLink() %>">
                <img src="<%= book.getImage() %>" alt="<%= book.getTitle() %>">
            </a>
            <div class="book-info">
                <h2><%= book.getTitle() %> <span>[중고상품 모두보기]</span></h2>
                <p><%= book.getAuthor() %> | <%= book.getPublisher() %> | <%= book.getYear() %></p>
                <p>총 중고상품 : <%= book.getTotalUsed() %>개 (baskin31.2 직배송 : <%= book.getBaskin31_2Used() %>개 / 판매자배송 : <%= book.getSellerUsed() %>개)</p>
                <p class="price">최저 <%= book.getMinPrice() %>원 (<%= book.getSalePercent() %>% 할인) ~ 최고 <%= book.getMaxPrice() %>원</p>
                <p>baskin31.2 새상품 : <%= book.getSalePrice() %>원 (<%= book.getSalePercent() %>% 할인) <a href="<%= book.getNewProductLink() %>">새상품 보기 ></a></p>
                <button class="preview-btn">미리보기</button>
            </div>
        </div>
        <% 
        
            }
        } else {
        %>
        <p>도서 목록이 없습니다.</p>
        <% } %>
    </div>

</body>
</html>
