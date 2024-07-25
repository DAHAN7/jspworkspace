<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, jakarta.servlet.*, jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서 등록 결과</title>
</head>
<body>
    <header class="header">
        <h1>도서 등록 결과</h1>
    </header>

    <main>
        <div class="container">
            <section class="result-section">
                <h2>도서 등록 결과</h2>
                <%
                    // 세션에서 memberNum을 가져옵니다.
                    HttpSession Session = request.getSession();
                    Integer memberNum = (Integer) session.getAttribute("memberNum");

                    if (memberNum == null) {
                        out.println("<p>세션에서 회원 정보를 찾을 수 없습니다. 로그인 후 다시 시도해 주세요.</p>");
                        return;
                    }

                    // name 속성이랑 일치하게 수정 파라미터를 가져옵니다.
                    String title = request.getParameter("title");
                    String author = request.getParameter("author");
                    String priceStr = request.getParameter("price");
                    String publisher = request.getParameter("publisher");
                    String description = request.getParameter("description");
                    String category = request.getParameter("category");
                    String stockStr = request.getParameter("stock");
                    String imagePath = request.getParameter("image_path");

                    if (title == null || author == null || priceStr == null || publisher == null || description == null || category == null || stockStr == null || imagePath == null) {
                        out.println("<p>모든 필드를 입력해 주세요.</p>");
                        return;
                    }

                    double price;
                    int stock;

                    try {
                        price = Double.parseDouble(priceStr);
                        stock = Integer.parseInt(stockStr);
                    } catch (NumberFormatException e) {
                        out.println("<p>가격 또는 재고 입력에 오류가 발생했습니다: " + e.getMessage() + "</p>");
                        return;
                    }

                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        // JDBC 드라이버를 로딩합니다 (MySQL 드라이버의 경우).
                        // Class.forName("com.mysql.cj.jdbc.Driver"); // 필요에 따라 주석을 해제하십시오.

                        // 데이터베이스 연결
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");

                        // SQL 쿼리
                        String sql = "INSERT INTO books (title, author, price, publisher, description, category, stock, seller_id, image_path, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, '중고책')";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, title);
                        pstmt.setString(2, author);
                        pstmt.setDouble(3, price);
                        pstmt.setString(4, publisher);
                        pstmt.setString(5, description);
                        pstmt.setString(6, category);
                        pstmt.setInt(7, stock);
                        pstmt.setInt(8, memberNum); // 세션에서 가져온 memberNum 사용
                        pstmt.setString(9, imagePath);

                        // SQL 실행
                        int rowsAffected = pstmt.executeUpdate();

                        if (rowsAffected > 0) {
                            out.println("<p>도서가 성공적으로 등록되었습니다.</p>");
                        } else {
                            out.println("<p>도서 등록에 실패했습니다.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
                    } finally {
                        // 자원 해제
                        if (pstmt != null) {
                            try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                        if (conn != null) {
                            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    }
                %>
                <a href="registerUsedBook.jsp">다시 등록하기</a>
            </section>
        </div>
    </main>
</body>
</html>
