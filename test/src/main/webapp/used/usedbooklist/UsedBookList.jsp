<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ page import="usedlist.Criteria, usedlist.PageMaker" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고서적 목록</title>
    <style>
        /* CSS 스타일 */
        body.loading::after {
            content: '로딩 중...';
            display: block;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.7);
            color: #000;
            text-align: center;
            padding-top: 20%;
            font-size: 24px;
            z-index: 1000;
        }
        .book-list {
            margin: 20px;
        }
        .book-info {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        .book-info img {
            max-width: 100px;
            margin-right: 10px;
        }
        .book-title {
            margin: 0;
            font-size: 18px;
        }
        .book-details {
            font-size: 14px;
        }
        .buttons button {
            margin-right: 5px;
        }
        .paging {
            margin: 20px;
        }
        .paging a,
        .paging span {
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #ddd;
            color: #000;
            margin: 0 2px;
            cursor: pointer;
        }
        .paging .active {
            background-color: #007bff;
            color: #fff;
        }
        .paging .disabled {
            color: #ddd;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <h1>중고서적 목록</h1>
    <a href="book_write.jsp">서적 등록하러 가기</a>

    <!-- 데이터베이스에서 총 서적 수 조회 -->
    <s:query var="totalBooksCount" dataSource="jdbc/baskin">
        SELECT COUNT(*) AS count FROM Used_Books WHERE status = '최상'
    </s:query>

    <!-- 페이지 설정 및 페이징 정보 -->
    <jsp:useBean id="cri" class="usedlist.Criteria" scope="page"/>
    <jsp:setProperty property="*" name="cri"/>
    <jsp:useBean id="pm" class="usedlist.PageMaker"/>
    <jsp:setProperty property="cri" name="pm" value="${cri}"/>
    <jsp:setProperty property="displayPageNum" name="pm" value="10"/>
    <jsp:setProperty property="totalCount" name="pm" value="${totalBooksCount.rows[0].count}"/>

    <!-- 서적 목록 조회 -->
    <s:query var="books" dataSource="jdbc/baskin">
        SELECT ub.*, b.title, b.author, b.price
        FROM Used_Books ub
        JOIN Books b ON ub.book_id = b.book_id
        WHERE ub.status = '최상'
        LIMIT ${cri.getStartRow()}, ${cri.getPerPageNum()}
    </s:query>

    <div class="book-list" id="bookList">
        <c:choose>
            <c:when test="${books.rowCount > 0}">
                <c:forEach var="book" items="${books.rows}">
                    <div class="book-info">
                        <img src="${book.image || 'default_image.jpg'}" alt="${book.description}">
                        <div>
                            <h2 class="book-title">${book.title}</h2>
                            <p class="book-details">가격: ${book.price}원 (상태: ${book.status})</p>
                            <p class="book-details">저자: ${book.author}</p>
                            <div class="buttons">
                                <button class="buy-now" data-used-book-id="${book.used_book_id}">바로구매</button>
                                <button class="add-to-list" data-used-book-id="${book.used_book_id}">리스트에 넣기</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>등록된 정보가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 페이지 네비게이션 -->
    <hr/>
    <c:if test="${cri.page > 1}">
        <a href="book_list.jsp?page=1">[처음]</a>
        <c:if test="${pm.getPrev()}">
            <a href="book_list.jsp?page=${pm.getStartPage() - 1}">[이전]</a>
        </c:if>
    </c:if>
    <c:forEach var="i" begin="${pm.getStartPage()}" end="${pm.getEndPage()}" step="1">
        <a href="book_list.jsp?page=${i}" class="${i == cri.page ? 'active' : ''}">[${i}]</a>
    </c:forEach>
    <c:if test="${cri.page < pm.getMaxPage()}">
        <c:if test="${pm.getNext()}">
            <a href="book_list.jsp?page=${pm.getEndPage() + 1}">[다음]</a>
        </c:if>
        <a href="book_list.jsp?page=${pm.getMaxPage()}">[마지막]</a>
    </c:if>

    <script>
        var currentPage = ${cri.page}; // 현재 페이지
        var totalPages = ${pm.getMaxPage()}; // 총 페이지 수

        // 페이지 로드 후 이벤트 리스너 설정
        document.addEventListener('DOMContentLoaded', function() {
            document.addEventListener('click', function(event) {
                if (event.target.classList.contains('buy-now')) {
                    var usedBookId = event.target.getAttribute('data-used-book-id');
                    handleBuyNow(usedBookId);
                } else if (event.target.classList.contains('add-to-list')) {
                    var usedBookId = event.target.getAttribute('data-used-book-id');
                    handleAddToList(usedBookId);
                }
            });
        });

        function handleBuyNow(usedBookId) {
            showLoading();

            var xhr = new XMLHttpRequest();
            xhr.open('POST', '?action=buyNow', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        alert('바로구매가 완료되었습니다.');
                    } else {
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                    hideLoading();
                }
            };
            xhr.send('usedBookId=' + encodeURIComponent(usedBookId));
        }

        function handleAddToList(usedBookId) {
            showLoading();

            var xhr = new XMLHttpRequest();
            xhr.open('POST', '?action=addToList', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        alert('리스트에 추가되었습니다.');
                    } else {
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                    hideLoading();
                }
            };
            xhr.send('usedBookId=' + encodeURIComponent(usedBookId));
        }

        function showLoading() {
            document.body.classList.add('loading');
        }

        function hideLoading() {
            document.body.classList.remove('loading');
        }
    </script>
</body>
</html>
