package usedlist;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/deleteBook")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC 드라이버 및 URL, 사용자 이름, 비밀번호는 설정에 맞게 수정하십시오.
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database";
    private static final String JDBC_USER = "your_username";
    private static final String JDBC_PASSWORD = "your_password";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");

        if (bookId == null || bookId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 요청입니다.");
            return;
        }

        try {
            deleteBook(bookId);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "서버 오류가 발생했습니다.");
        }
    }

    private void deleteBook(String bookId) throws SQLException {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "DELETE FROM books WHERE book_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, Integer.parseInt(bookId));
                int rowsAffected = statement.executeUpdate();

                if (rowsAffected == 0) {
                    throw new SQLException("도서를 삭제할 수 없습니다. 도서 ID가 존재하지 않습니다.");
                }
            }
        }
    }
}
