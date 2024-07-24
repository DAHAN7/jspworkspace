package used;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/api/books")
public class BookSearchServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/baskin";
    private static final String DB_USER = "digital";
    private static final String DB_PASSWORD = "1234";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");

        // 데이터베이스 검색 로직
        String jsonResponse;
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT title, author, price, publisher, description, category, stock, seller_id, image_path, status " +
                         "FROM books WHERE title LIKE ? OR author LIKE ? OR publisher LIKE ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                String searchQuery = "%" + query + "%";
                pstmt.setString(1, searchQuery);
                pstmt.setString(2, searchQuery);
                pstmt.setString(3, searchQuery);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        // 검색 결과가 있는 경우
                        jsonResponse = "{"
                                + "\"book\": {"
                                + "\"title\": \"" + escapeJson(rs.getString("title")) + "\","
                                + "\"author\": \"" + escapeJson(rs.getString("author")) + "\","
                                + "\"price\": \"" + escapeJson(rs.getString("price")) + "\","
                                + "\"publisher\": \"" + escapeJson(rs.getString("publisher")) + "\","
                                + "\"description\": \"" + escapeJson(rs.getString("description")) + "\","
                                + "\"category\": \"" + escapeJson(rs.getString("category")) + "\","
                                + "\"stock\": " + rs.getInt("stock") + ","
                                + "\"seller_id\": \"" + escapeJson(rs.getString("seller_id")) + "\","
                                + "\"image\": \"" + escapeJson(rs.getString("image_path")) + "\","
                                + "\"status\": \"" + escapeJson(rs.getString("status")) + "\""
                                + "}"
                                + "}";
                    } else {
                        jsonResponse = "{\"book\": null}";
                    }
                }
            } catch (SQLException e) {
                jsonResponse = "{\"success\": false, \"message\": \"데이터베이스 오류: " + escapeJson(e.getMessage()) + "\"}";
            }
        } catch (SQLException e) {
            jsonResponse = "{\"success\": false, \"message\": \"데이터베이스 연결 오류: " + escapeJson(e.getMessage()) + "\"}";
        }

        // 응답 작성
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }

    private String escapeJson(String str) {
        if (str == null) {
            return "";
        }
        // JSON 문자열에서 사용되는 특수 문자들을 이스케이프 처리합니다.
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
