<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>중고서적 목록</title>
    <style>
        /* CSS 스타일은 여기에 포함 */
        .book-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
            box-sizing: border-box;
        }
        .book-info {
            width: 100%;
            max-width: 300px;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 5px;
            box-sizing: border-box;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .book-info img {
            width: 100%;
            height: auto;
            border-radius: 5px 5px 0 0;
        }
        .book-title {
            font-size: 1.2em;
            margin: 10px 0;
        }
        .book-details {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 10px;
        }
        .buttons {
            display: flex;
            justify-content: space-between;
        }
        .buttons button {
            padding: 8px 12px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background-color 0.3s ease;
        }
        .buy-now {
            background-color: #4CAF50;
            color: white;
        }
        .add-to-list {
            background-color: #008CBA;
            color: white;
        }
        .buy-now:hover,
        .add-to-list:hover {
            opacity: 0.8;
        }
        .paging {
            margin-top: 20px;
        }
        .paging a {
            padding: 5px 10px;
            text-decoration: none;
            color: #333;
            border: 1px solid #ccc;
            margin-right: 5px;
            border-radius: 3px;
        }
        .paging a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        .loading {
            cursor: progress;
            pointer-events: none;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="book-list">
        <%
            String jdbcUrl = "jdbc:mysql://localhost:3306/digital_jsp";
            String dbUser = "digital";
            String dbPassword = "1234";
            int pageCount = 5; // 한 페이지에 보여질 게시물 수
            int currentPage = 1; // 현재 페이지

            // 현재 페이지 파라미터 확인 및 설정
            String paramPage = request.getParameter("currentPage");
            if (paramPage != null && !paramPage.isEmpty()) {
                currentPage = Integer.parseInt(paramPage);
            }

            int startRow = (currentPage - 1) * pageCount; // 시작 행 계산
            int totalPages = 0; // totalPages 변수 초기화

            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                // 중고서적 총 레코드 수 조회
                String countSQL = "SELECT COUNT(*) AS count FROM Used_Books WHERE status = '최상'";
                try (Statement countStmt = conn.createStatement();
                     ResultSet countRs = countStmt.executeQuery(countSQL)) {
                    countRs.next();
                    int totalRecords = countRs.getInt("count");
                    totalPages = (int) Math.ceil((double) totalRecords / pageCount);

                    // 중고서적 목록 조회
                    String selectSQL = "SELECT * FROM Used_Books WHERE status = '최상' LIMIT ?, ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(selectSQL)) {
                        pstmt.setInt(1, startRow);
                        pstmt.setInt(2, pageCount);
                        try (ResultSet rs = pstmt.executeQuery()) {
                            while (rs.next()) {
                                int usedBookId = rs.getInt("used_book_id");
                                String description = rs.getString("description");
                                int price = rs.getInt("price");
                                String status = rs.getString("status");
                                String bookImage = rs.getString("image");

                                if (bookImage == null || bookImage.isEmpty()) {
                                    bookImage = request.getContextPath() + "/images/default_image.jpg";
                                }
        %>
        <div class="book-info">
            <img src="<%= bookImage %>" alt="<%= description %>">
            <h2 class="book-title"><%= description %></h2>
            <p class="book-details">가격: <%= price %>원 (상태: <%= status %>)</p>
            <div class="buttons">
                <button class="buy-now" data-used-book-id="<%= usedBookId %>">바로구매</button>
                <button class="add-to-list" data-used-book-id="<%= usedBookId %>">리스트에 넣기</button>
            </div>
        </div>
        <%
                            }
                        }
                    }
                }
            } catch (SQLException e) {
                out.println("데이터베이스 오류 발생: " + e.getMessage());
            }
        %>
    </div>

    <div class="paging">
        <%
            // 페이징 처리
            if (currentPage > 1) {
                out.print("<a href=\"?currentPage=" + (currentPage - 1) + "\">이전</a> ");
            }

            for (int i = 1; i <= totalPages; i++) {
                if (i == currentPage) {
                    out.print("<a class='active' href=\"?currentPage=" + i + "\">" + i + "</a> ");
                } else {
                    out.print("<a href=\"?currentPage=" + i + "\">" + i + "</a> ");
                }
            }

            if (currentPage < totalPages) {
                out.print("<a href=\"?currentPage=" + (currentPage + 1) + "\">다음</a>");
            }
        %>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 바로구매 및 리스트 넣기 버튼에 대한 클릭 이벤트 처리
            document.querySelectorAll('.buy-now').forEach(button => {
                button.addEventListener('click', function() {
                    var usedBookId = this.getAttribute('data-used-book-id');
                    handleBuyNow(usedBookId);
                });
            });

            document.querySelectorAll('.add-to-list').forEach(button => {
                button.addEventListener('click', function() {
                    var usedBookId = this.getAttribute('data-used-book-id');
                    handleAddToList(usedBookId);
                });
            });

            function handleBuyNow(usedBookId) {
                showLoading(); // 로딩 화면 표시

                // Ajax를 사용하여 서버에 바로구매 요청
                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'buyNowServlet', true);
                xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // 바로구매 성공 시 추가적인 처리 (예: 메시지 출력 등)
                            alert('바로구매가 완료되었습니다.');
                        } else {
                            // 오류 처리
                            alert('오류가 발생했습니다. 다시 시도해주세요.');
                        }
                        hideLoading(); // 로딩 화면 숨기기
                    }
                };
                xhr.send('usedBookId=' + encodeURIComponent(usedBookId));
            }

            function handleAddToList(usedBookId) {
                showLoading(); // 로딩 화면 표시

                // Ajax를 사용하여 서버에 리스트 추가 요청
                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'addToListServlet', true);
                xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // 리스트 추가 성공 시 추가적인 처리 (예: 메시지 출력 등)
                            alert('리스트에 추가되었습니다.');
                        } else {
                            // 오류 처리
                            alert('오류가 발생했습니다. 다시 시도해주세요.');
                        }
                        hideLoading(); // 로딩 화면 숨기기
                    }
                };
                xhr.send('usedBookId=' + encodeURIComponent(usedBookId));
            }

            function showLoading() {
                document.body.classList.add('loading'); // 로딩 클래스 추가
            }

            function hideLoading() {
                document.body.classList.remove('loading'); // 로딩 클래스 제거
            }
        });
    </script>
</body>
</html>
