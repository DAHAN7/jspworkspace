package usedlist;

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
import jakarta.servlet.http.HttpSession;

@WebServlet("/buyNowServlet")
public class BuyNowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:/comp/env/jdbc/MySQLDB"); 
        } catch (NamingException e) {
            throw new ServletException("데이터베이스 연결 설정 오류입니다.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 사용자 세션 검증
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String usedBookIdStr = request.getParameter("usedBookId");

        // 입력 데이터 유효성 검사
        if (usedBookIdStr == null || usedBookIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "중고 도서 ID가 필요합니다.");
            return;
        }

        int usedBookId;
        try {
            usedBookId = Integer.parseInt(usedBookIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 중고 도서 ID입니다.");
            return;
        }

        // 도서의 상태 및 재고 확인
        String checkBookSql = "SELECT status, stock FROM books WHERE book_id = ?";
        String insertPurchaseSql = "INSERT INTO UserPurchases (user_id, used_book_id) VALUES (?, ?)";
        String updateStockSql = "UPDATE books SET stock = stock - 1 WHERE book_id = ? AND stock > 0";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkBookSql);
             PreparedStatement insertStmt = conn.prepareStatement(insertPurchaseSql);
             PreparedStatement updateStmt = conn.prepareStatement(updateStockSql)) {

            // 도서 상태 및 재고 확인
            checkStmt.setInt(1, usedBookId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");
                int stock = rs.getInt("stock");

                if ("중고책".equals(status)) {
                    if (stock > 0) {
                        // 구매 기록 삽입
                        insertStmt.setInt(1, userId);
                        insertStmt.setInt(2, usedBookId);

                        int rowsAffected = insertStmt.executeUpdate();
                        if (rowsAffected > 0) {
                            // 구매 후 재고 감소 처리
                            updateStmt.setInt(1, usedBookId);
                            int rowsUpdated = updateStmt.executeUpdate();
                            if (rowsUpdated > 0) {
                                response.setStatus(HttpServletResponse.SC_OK);
                                response.getWriter().write("바로 구매가 완료되었습니다.");
                            } else {
                                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "재고 업데이트 중 오류 발생");
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "구매 등록에 실패하였습니다.");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "재고가 부족하여 구매할 수 없습니다.");
                    }
                } else if ("신책".equals(status)) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "새 책은 구매할 수 없습니다.");
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 도서 상태입니다.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "도서를 찾을 수 없습니다.");
            }
        } catch (SQLException e) {
            throw new ServletException("구매 처리 중 데이터베이스 오류 발생", e);
        }
    }
}
