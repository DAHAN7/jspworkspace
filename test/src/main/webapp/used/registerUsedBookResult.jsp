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
                        out.println("<p>세션에서 회원 정보를 찾을 수 없습니다. </p>");
                        return;
                    }

                    // 폼 파라미터를 가져옵니다.
                    String title = request.getParameter("title");
                    String author = request.getParameter("author");
                    String priceStr = request.getParameter("price");
                    String condition = request.getParameter("condition");
                    String description = request.getParameter("description");
                    Part imagePart = request.getPart("images");  // 파일 업로드 처리

                    if (title == null || author == null || priceStr == null || condition == null || imagePart == null) {
                        out.println("<p>모든 필드를 입력해 주세요.</p>");
                        return;
                    }

                    double price;
                    try {
                        price = Double.parseDouble(priceStr);
                    } catch (NumberFormatException e) {
                        out.println("<p>가격 입력에 오류가 발생했습니다: " + e.getMessage() + "</p>");
                        return;
                    }

                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");

                        String sql = "INSERT INTO used_books (title, author, price, condition, description, seller_id, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, title);
                        pstmt.setString(2, author);
                        pstmt.setDouble(3, price);
                        pstmt.setString(4, condition);
                        pstmt.setString(5, description);
                        pstmt.setInt(6, memberNum);
                        pstmt.setBlob(7, imagePart.getInputStream());  // 이미지 파일을 Blob으로 저장

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
