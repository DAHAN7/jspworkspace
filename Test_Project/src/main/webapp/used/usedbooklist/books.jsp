<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고 도서 목록</title>
    <style>
        /* 기본 스타일 */
        body {
            font-family: Arial, sans-serif; /* 폰트 설정 */
            margin: 0;
            padding: 0;
        }

        /* 헤더 스타일 */
        .header {
            background-color: #333; /* 배경 색상 */
            color: #fff; /* 글자 색상 */
            padding: 15px 0; /* 상하 여백 */
            text-align: center; /* 가운데 정렬 */
        }

        /* 컨테이너 스타일 */
        .container {
            max-width: 1200px; /* 최대 너비 */
            margin: 0 auto; /* 가운데 정렬 */
            padding: 20px; /* 여백 */
        }

        /* 카테고리 스타일 */
        .category {
            border: 1px solid #ccc; /* 테두리 색상 */
            padding: 10px; /* 여백 */
            background-color: #f5f5f5; /* 배경 색상 */
        }

        /* 카테고리 항목 스타일 */
        .category-item {
            margin: 10px 0; /* 상하 여백 */
        }

        /* 카테고리 버튼 스타일 */
        .category-title {
            background: #f5f5f5; /* 배경 색상 */
            border: 1px solid #ccc; /* 테두리 색상 */
            padding: 10px; /* 여백 */
            cursor: pointer; /* 커서 모양 */
            width: 100%; /* 너비 100% */
            text-align: left; /* 왼쪽 정렬 */
        }

        /* 서브카테고리 목록 스타일 */
        .subcategory-list {
            display: none; /* 기본적으로 숨김 */
            list-style: none; /* 목록 스타일 제거 */
            padding: 0; /* 패딩 제거 */
        }

        /* 서브카테고리 항목 스타일 */
        .subcategory-list li {
            background: #e9e9e9; /* 배경 색상 */
            border-bottom: 1px solid #ccc; /* 하단 테두리 색상 */
            padding: 10px; /* 여백 */
        }

        /* 책 정보 스타일 */
        .book-info {
            margin: 5px 0; /* 상하 여백 */
        }

        /* 화살표 스타일 */
        .arrow {
            border: solid #333; /* 테두리 색상 */
            border-width: 0 2px 2px 0; /* 테두리 두께 */
            display: inline-block; /* 인라인 블록 요소 */
            padding: 3px; /* 패딩 */
        }

        .arrow.down {
            transform: rotate(45deg); /* 회전 효과 */
            -webkit-transform: rotate(45deg); /* 웹킷 브라우저 호환 */
        }
    </style>
</head>
<body>
    <!-- 헤더 -->
    <header class="header">
        <h1>중고 도서 목록</h1>
    </header>
    
    <!-- 메인 콘텐츠 -->
    <main>
        <div class="container">
            <!-- 카테고리 네비게이션 -->
            <nav class="category">
                <h2>카테고리</h2>
                <ul>
                    <% 
                        // 데이터베이스 연결 정보
                        String jdbcURL = "jdbc:mysql://localhost:3306/baskin";
                        String jdbcUsername = "digital"; 
                        String jdbcPassword = "1234"; 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            // 데이터베이스 연결
                            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                            stmt = conn.createStatement();
                            
                            // 카테고리 목록 가져오기
                            String categorySQL = "SELECT DISTINCT category FROM Books";
                            rs = stmt.executeQuery(categorySQL);
                            
                            // 카테고리 목록 출력
                            while (rs.next()) {
                                String category = rs.getString("category");
                    %>
                    <li class="category-item">
                        <!-- 카테고리 버튼 -->
                        <button class="category-title" onclick="toggleDropdown('<%= category %>')">
                            <%= category %> <i class="arrow down"></i>
                        </button>
                        <!-- 서브카테고리 목록 -->
                        <ul id="<%= category %>" class="subcategory-list">
                            <% 
                                // 서브카테고리(중고 도서) 목록 가져오기
                                String usedBooksSQL = "SELECT * FROM Used_Books INNER JOIN Books ON Used_Books.book_id = Books.book_id WHERE Books.category = ?";
                                PreparedStatement pstmt = conn.prepareStatement(usedBooksSQL);
                                pstmt.setString(1, category);
                                ResultSet usedBooksRS = pstmt.executeQuery();
                                
                                // 중고 도서 목록 출력
                                while (usedBooksRS.next()) {
                                    String bookTitle = usedBooksRS.getString("title");
                                    int price = usedBooksRS.getInt("price");
                                    String status = usedBooksRS.getString("status");
                                    String description = usedBooksRS.getString("description");
                            %>
                            <li>
                                <!-- 책 정보 -->
                                <div class="book-info">
                                    <h3><%= bookTitle %></h3>
                                    <p>가격: <%= price %> 원</p>
                                    <p>상태: <%= status %></p>
                                    <p>설명: <%= description %></p>
                                </div>
                            </li>
                            <% 
                                }
                                usedBooksRS.close();
                            %>
                        </ul>
                    </li>
                    <% 
                            }
                            rs.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                // 자원 해제
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </ul>
            </nav>
        </div>
    </main>
    
    <!-- JavaScript 코드 -->
    <script>
        // 카테고리 클릭 시 서브카테고리 목록 토글
        function toggleDropdown(categoryId) {
            const dropdown = document.getElementById(categoryId);
            if (dropdown.style.display === "block") {
                dropdown.style.display = "none";
            } else {
                dropdown.style.display = "block";
            }
        }
    </script>
</body>
</html>
