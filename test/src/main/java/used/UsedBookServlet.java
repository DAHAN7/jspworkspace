package used;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookServlet")
public class UsedBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("/jdbc/MySQLDB");
        } catch (NamingException e) {
            throw new ServletException("데이터베이스 연결 설정 오류입니다.", e);
        }
    }

    // 도서 추가
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String stockStr = request.getParameter("stock");
        String sellerIdStr = request.getParameter("seller_id");
        String imagePath = request.getParameter("image_path");
        String status = request.getParameter("status");

        if (title == null || author == null || priceStr == null || description == null || category == null || stockStr == null || imagePath == null || status == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "필수 데이터가 부족합니다.");
            return;
        }

        int price;
        int stock;
        Integer sellerId = null;

        try {
            price = Integer.parseInt(priceStr);
            stock = Integer.parseInt(stockStr);
            if (!sellerIdStr.isEmpty()) {
                sellerId = Integer.parseInt(sellerIdStr);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "가격 또는 재고 수량이 유효하지 않습니다.");
            return;
        }

        String sql = "INSERT INTO books (title, author, publisher, price, description, category, stock, seller_id, image_path, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, title);
            pstmt.setString(2, author);
            pstmt.setString(3, publisher);
            pstmt.setInt(4, price);
            pstmt.setString(5, description);
            pstmt.setString(6, category);
            pstmt.setInt(7, stock);
            if (sellerId != null) {
                pstmt.setInt(8, sellerId);
            } else {
                pstmt.setNull(8, java.sql.Types.INTEGER);
            }
            pstmt.setString(9, imagePath);
            pstmt.setString(10, status);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"도서가 성공적으로 추가되었습니다.\"}");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "도서 추가에 실패하였습니다.");
            }
        } catch (SQLException e) {
            throw new ServletException("도서 추가 중 데이터베이스 오류 발생", e);
        }
    }

    // 도서 조회
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdStr = request.getParameter("book_id");
        if (bookIdStr == null || bookIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "도서 ID가 필요합니다.");
            return;
        }

        int bookId;
        try {
            bookId = Integer.parseInt(bookIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 도서 ID입니다.");
            return;
        }

        String sql = "SELECT * FROM books WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{"
                            + "\"book_id\": " + rs.getInt("book_id") + ","
                            + "\"title\": \"" + rs.getString("title") + "\","
                            + "\"author\": \"" + rs.getString("author") + "\","
                            + "\"publisher\": \"" + rs.getString("publisher") + "\","
                            + "\"price\": " + rs.getInt("price") + ","
                            + "\"description\": \"" + rs.getString("description") + "\","
                            + "\"category\": \"" + rs.getString("category") + "\","
                            + "\"stock\": " + rs.getInt("stock") + ","
                            + "\"seller_id\": " + (rs.getObject("seller_id") != null ? rs.getInt("seller_id") : "null") + ","
                            + "\"image_path\": \"" + rs.getString("image_path") + "\","
                            + "\"status\": \"" + rs.getString("status") + "\""
                            + "}");
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "도서를 찾을 수 없습니다.");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("도서 조회 중 데이터베이스 오류 발생", e);
        }
    }

    // 도서 업데이트
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdStr = request.getParameter("book_id");
        if (bookIdStr == null || bookIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "도서 ID가 필요합니다.");
            return;
        }

        int bookId;
        try {
            bookId = Integer.parseInt(bookIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 도서 ID입니다.");
            return;
        }

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String stockStr = request.getParameter("stock");
        String sellerIdStr = request.getParameter("seller_id");
        String imagePath = request.getParameter("image_path");
        String status = request.getParameter("status");

        if (title == null || author == null || priceStr == null || description == null || category == null || stockStr == null || imagePath == null || status == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "필수 데이터가 부족합니다.");
            return;
        }

        int price;
        int stock;
        Integer sellerId = null;

        try {
            price = Integer.parseInt(priceStr);
            stock = Integer.parseInt(stockStr);
            if (!sellerIdStr.isEmpty()) {
                sellerId = Integer.parseInt(sellerIdStr);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "가격 또는 재고 수량이 유효하지 않습니다.");
            return;
        }

        String sql = "UPDATE books SET title = ?, author = ?, publisher = ?, price = ?, description = ?, category = ?, stock = ?, seller_id = ?, image_path = ?, status = ? WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, title);
            pstmt.setString(2, author);
            pstmt.setString(3, publisher);
            pstmt.setInt(4, price);
            pstmt.setString(5, description);
            pstmt.setString(6, category);
            pstmt.setInt(7, stock);
            if (sellerId != null) {
                pstmt.setInt(8, sellerId);
            } else {
                pstmt.setNull(8, java.sql.Types.INTEGER);
            }
            pstmt.setString(9, imagePath);
            pstmt.setString(10, status);
            pstmt.setInt(11, bookId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"도서가 성공적으로 업데이트되었습니다.\"}");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "도서 업데이트에 실패하였습니다.");
            }
        } catch (SQLException e) {
            throw new ServletException("도서 업데이트 중 데이터베이스 오류 발생", e);
        }
    }

    // 도서 삭제
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookIdStr = request.getParameter("book_id");
        if (bookIdStr == null || bookIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "도서 ID가 필요합니다.");
            return;
        }

        int bookId;
        try {
            bookId = Integer.parseInt(bookIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 도서 ID입니다.");
            return;
        }

        String sql = "DELETE FROM books WHERE book_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, bookId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true, \"message\": \"도서가 성공적으로 삭제되었습니다.\"}");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "도서 삭제에 실패하였습니다.");
            }
        } catch (SQLException e) {
            throw new ServletException("도서 삭제 중 데이터베이스 오류 발생", e);
        }
    }
}
