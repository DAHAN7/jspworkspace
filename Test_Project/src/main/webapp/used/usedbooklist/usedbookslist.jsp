<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>중고서적 목록</title>
    <style>
        /* CSS 스타일은 여기에 포함 */
    </style>
</head>
<body>
    <div class="book-list" id="bookList"></div>
    <div class="paging" id="paging"></div>

    <script>
        var currentPage = 1; // 현재 페이지
        var totalPages = 0;  // 총 페이지 수

        document.addEventListener('DOMContentLoaded', function() {
            loadBooks(currentPage);

            document.addEventListener('click', function(event) {
                if (event.target.tagName === 'A' && event.target.classList.contains('page-link')) {
                    event.preventDefault();
                    currentPage = parseInt(event.target.getAttribute('data-page'));
                    loadBooks(currentPage);
                } else if (event.target.classList.contains('buy-now')) {
                    var usedBookId = event.target.getAttribute('data-used-book-id');
                    handleBuyNow(usedBookId);
                } else if (event.target.classList.contains('add-to-list')) {
                    var usedBookId = event.target.getAttribute('data-used-book-id');
                    handleAddToList(usedBookId);
                }
            });
        });

        function loadBooks(page) {
            showLoading();

            var xhr = new XMLHttpRequest();
            xhr.open('GET', '?action=loadBooks&page=' + page, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        displayBooks(response.books);
                        updatePaging(response.totalPages);
                    } else {
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                    hideLoading();
                }
            };
            xhr.send();
        }

        function displayBooks(books) {
            var bookList = document.getElementById('bookList');
            bookList.innerHTML = '';

            books.forEach(book => {
                var bookDiv = document.createElement('div');
                bookDiv.className = 'book-info';
                bookDiv.innerHTML = `
                    <img src="${book.image || 'default_image.jpg'}" alt="${book.description}">
                    <h2 class="book-title">${book.description}</h2>
                    <p class="book-details">가격: ${book.price}원 (상태: ${book.status})</p>
                    <div class="buttons">
                        <button class="buy-now" data-used-book-id="${book.usedBookId}">바로구매</button>
                        <button class="add-to-list" data-used-book-id="${book.usedBookId}">리스트에 넣기</button>
                    </div>
                `;
                bookList.appendChild(bookDiv);
            });
        }

        function updatePaging(totalPages) {
            var pagingDiv = document.getElementById('paging');
            pagingDiv.innerHTML = '';

            if (currentPage > 1) {
                pagingDiv.innerHTML += `<a href="#" class="page-link" data-page="${currentPage - 1}">이전</a> `;
            }

            for (let i = 1; i <= totalPages; i++) {
                pagingDiv.innerHTML += `<a href="#" class="page-link ${i === currentPage ? 'active' : ''}" data-page="${i}">${i}</a> `;
            }

            if (currentPage < totalPages) {
                pagingDiv.innerHTML += `<a href="#" class="page-link" data-page="${currentPage + 1}">다음</a>`;
            }
        }

        function showLoading() {
            document.body.classList.add('loading');
        }

        function hideLoading() {
            document.body.classList.remove('loading');
        }

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
    </script>

    <%-- 서버 측 로직 --%>
    <%
        String action = request.getParameter("action");
        PrintWriter out = response.getWriter(); // PrintWriter를 한 번만 선언

        if (action != null) {
            if (action.equals("loadBooks")) {
                int pageNumber = Integer.parseInt(request.getParameter("page"));
                int pageCount = 5;
                int startRow = (pageNumber - 1) * pageCount;
                int totalPages = 0;

                response.setContentType("application/json; charset=UTF-8");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String jdbcUrl = "jdbc:mysql://localhost:3306/bookstore";
                    String dbUser = "your_username";
                    String dbPassword = "your_password";

                    try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                        // 중고서적 총 레코드 수 조회
                        String countSQL = "SELECT COUNT(*) AS count FROM Used_Books WHERE status = '최상'";
                        try (Statement countStmt = conn.createStatement();
                             ResultSet countRs = countStmt.executeQuery(countSQL)) {
                            countRs.next();
                            int totalRecords = countRs.getInt("count");
                            totalPages = (int) Math.ceil((double) totalRecords / pageCount);
                        }

                        // 중고서적 목록 조회
                        String selectSQL = "SELECT * FROM Used_Books WHERE status = '최상' LIMIT ?, ?";
                        try (PreparedStatement pstmt = conn.prepareStatement(selectSQL)) {
                            pstmt.setInt(1, startRow);
                            pstmt.setInt(2, pageCount);
                            try (ResultSet rs = pstmt.executeQuery()) {
                                StringBuilder jsonBuilder = new StringBuilder();
                                jsonBuilder.append("{\"books\":[");

                                while (rs.next()) {
                                    if (jsonBuilder.length() > 12) {
                                        jsonBuilder.append(",");
                                    }
                                    int usedBookId = rs.getInt("used_book_id");
                                    String description = rs.getString("description");
                                    int price = rs.getInt("price");
                                    String status = rs.getString("status");
                                    String image = rs.getString("image");
                                    if (image == null || image.isEmpty()) {
                                        image = request.getContextPath() + "/images/default_image.jpg";
                                    }

                                    jsonBuilder.append("{\"usedBookId\":").append(usedBookId)
                                                .append(",\"description\":\"").append(description)
                                                .append("\",\"price\":").append(price)
                                                .append(",\"status\":\"").append(status)
                                                .append("\",\"image\":\"").append(image).append("\"}");
                                }
                                jsonBuilder.append("],\"totalPages\":").append(totalPages).append("}");

                                out.print(jsonBuilder.toString());
                            }
                        }
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
            } else if (action.equals("buyNow") || action.equals("addToList")) {
                // buyNow 또는 addToList 처리 로직 (추가 필요)
            }
        }
    %>
</body>
</html>
