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

	private static final long serialVersionUID = -8395914846321777942L;
	
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
            String sql = "SELECT book_id, title, author, publisher, price, description, category, stock, seller_id, image_path, status " +
                         "FROM books WHERE title LIKE ? OR author LIKE ? OR publisher LIKE ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                String searchQuery = "%" + query + "%";
                pstmt.setString(1, searchQuery);
                pstmt.setString(2, searchQuery);
                pstmt.setString(3, searchQuery);

                try (ResultSet rs = pstmt.executeQuery()) {
                    StringBuilder jsonBuilder = new StringBuilder();
                    jsonBuilder.append("{ \"books\": [");
                    
                    boolean first = true;
                    while (rs.next()) {
                        if (!first) {
                            jsonBuilder.append(",");
                        }
                        jsonBuilder.append("{")
                                .append("\"book_id\": ").append(rs.getInt("book_id")).append(",")
                                .append("\"title\": \"").append(escapeJson(rs.getString("title"))).append("\",")
                                .append("\"author\": \"").append(escapeJson(rs.getString("author"))).append("\",")
                                .append("\"publisher\": \"").append(escapeJson(rs.getString("publisher"))).append("\",")
                                .append("\"price\": ").append(rs.getInt("price")).append(",")
                                .append("\"description\": \"").append(escapeJson(rs.getString("description"))).append("\",")
                                .append("\"category\": \"").append(escapeJson(rs.getString("category"))).append("\",")
                                .append("\"stock\": ").append(rs.getInt("stock")).append(",")
                                .append("\"seller_id\": ").append(rs.getInt("seller_id")).append(",")
                                .append("\"image_path\": \"").append(escapeJson(rs.getString("image_path"))).append("\",")
                                .append("\"status\": \"").append(escapeJson(rs.getString("status"))).append("\"")
                                .append("}");
                        first = false;
                    }
                    jsonBuilder.append("]}");

                    jsonResponse = jsonBuilder.toString();
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
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
