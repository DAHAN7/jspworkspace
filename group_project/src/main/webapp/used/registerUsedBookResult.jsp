<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, jakarta.servlet.*, jakarta.servlet.http.*, jakarta.servlet.http.Part" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고책 등록 결과</title>
</head>
<body>
    <header class="header">
        <h1>중고책 등록 결과</h1>
    </header>

    <main>
        <div class="container">
            <section class="result-section">
                <h2>중고책 등록 결과</h2>
                <%
                    // 세션에서 memberNum을 가져옵니다.
                    HttpSession Session = request.getSession();
                    Integer memberNum = (Integer) session.getAttribute("memberNum");

                    if (memberNum == null) {
                        out.println("<p>세션에서 회원 정보를 찾을 수 없습니다. 로그인 후 다시 시도해 주세요.</p>");
                        return;
                    }

                    String title = request.getParameter("title");
                    String author = request.getParameter("author");
                    String priceStr = request.getParameter("price");
                    String publisher = request.getParameter("publisher");
                    String description = request.getParameter("description");
                    String category = request.getParameter("category");
                    String stockStr = request.getParameter("stock");
                    Part imagePart = request.getPart("image");  // 파일 업로드 처리
                    String status = request.getParameter("status");

                    if (title == null || author == null || priceStr == null || publisher == null || description == null || category == null || stockStr == null || status == null || imagePart == null) {
                        out.println("<p>모든 필드를 입력해 주세요.</p>");
                        return;
                    }

                    int price;
                    int stock;
                    try {
                        price = Integer.parseInt(priceStr);
                        stock = Integer.parseInt(stockStr);
                    } catch (NumberFormatException e) {
                        out.println("<p>가격 또는 재고 입력에 오류가 발생했습니다: " + e.getMessage() + "</p>");
                        return;
                    }

                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");

                        String sql = "INSERT INTO books (title, author, price, publisher, description, category, stock, seller_id, image_path, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, title);
                        pstmt.setString(2, author);
                        pstmt.setInt(3, price);
                        pstmt.setString(4, publisher);
                        pstmt.setString(5, description);
                        pstmt.setString(6, category);
                        pstmt.setInt(7, stock);
                        pstmt.setInt(8, memberNum);

                        if (imagePart.getSize() > 0) {
                            String imagePath = "images/" + System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                            String uploadPath = getServletContext().getRealPath("/") + imagePath;
                            imagePart.write(uploadPath);
                            pstmt.setString(9, imagePath);
                        } else {
                            pstmt.setNull(9, java.sql.Types.VARCHAR);  // 이미지가 없으면 NULL로 설정
                        }

                        pstmt.setString(10, status);

                        int rowsAffected = pstmt.executeUpdate();

                        if (rowsAffected > 0) {
                            out.println("<p>중고책이 성공적으로 등록되었습니다.</p>");
                        } else {
                            out.println("<p>중고책 등록에 실패했습니다. 다시 시도해 주세요.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
                        e.printStackTrace();
                    } finally {
                        try {
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
                <a href="registerUsedBook.jsp">다시 등록하기</a>
            </section>
        </div>
    </main>
</body>
</html>
