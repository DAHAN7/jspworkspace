package usedlist;

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

@WebServlet("/addToListServlet")
public class AddToListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("/jdbc/baskin");
        } catch (NamingException e) {
            throw new ServletException("DataSource를 불러오는데 실패했습니다.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String usedBookIdStr = request.getParameter("usedBookId");

        if (usedBookIdStr == null || usedBookIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "중고 책 ID가 필요합니다.");
            return;
        }

        int usedBookId;
        try {
            usedBookId = Integer.parseInt(usedBookIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 중고 책 ID입니다.");
            return;
        }

        String sql = "INSERT INTO UserLists (user_id, used_book_id) VALUES (?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, usedBookId);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("리스트에 추가되었습니다.");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "리스트 추가에 실패했습니다.");
            }
        } catch (SQLException e) {
            throw new ServletException("Database 오류발생", e);
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
