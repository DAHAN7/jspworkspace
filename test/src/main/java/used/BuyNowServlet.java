package used;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/MySQLDB");
        } catch (NamingException e) {
            throw new ServletException("Database connection setup problem.", e);
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

        // 데이터베이스에 구매 정보 저장
        try (Connection conn = dataSource.getConnection()) {
            String sql = "INSERT INTO UserPurchases (user_id, used_book_id) VALUES (?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setInt(2, usedBookId);
                int rowsAffected = stmt.executeUpdate();
                
                // INSERT 성공 여부 확인
                if (rowsAffected > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("바로구매가 완료되었습니다.");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "구매 등록에 실패하였습니다.");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error during purchase processing.", e);
        }
    }
}
