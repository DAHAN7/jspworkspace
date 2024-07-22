package used;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/digital_jsp")
public class UsedBookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 데이터베이스 연결 정보
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/digital_jsp";
    private static final String JDBC_USER = "digital";
    private static final String JDBC_PASSWORD = "1234";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"en\">");
            out.println("<head>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<title>중고 도서 목록</title>");
            out.println("<style>");
            out.println("/* 기본 스타일 */");
            out.println("body { font-family: Arial, sans-serif; margin: 0; padding: 0; }");
            out.println("/* 헤더 스타일 */");
            out.println(".header { background-color: #333; color: #fff; padding: 15px 0; text-align: center; }");
            out.println("/* 컨테이너 스타일 */");
            out.println(".container { max-width: 1200px; margin: 0 auto; padding: 20px; }");
            out.println("/* 카테고리 스타일 */");
            out.println(".category { border: 1px solid #ccc; padding: 10px; background-color: #f5f5f5; }");
            out.println("/* 카테고리 항목 스타일 */");
            out.println(".category-item { margin: 10px 0; }");
            out.println("/* 카테고리 버튼 스타일 */");
            out.println(".category-title { background: #f5f5f5; border: 1px solid #ccc; padding: 10px; cursor: pointer; width: 100%; text-align: left; }");
            out.println("/* 서브카테고리 목록 스타일 */");
            out.println(".subcategory-list { display: none; list-style: none; padding: 0; }");
            out.println("/* 서브카테고리 항목 스타일 */");
            out.println(".subcategory-list li { background: #e9e9e9; border-bottom: 1px solid #ccc; padding: 10px; }");
            out.println("/* 책 정보 스타일 */");
            out.println(".book-info { margin: 5px 0; }");
            out.println("/* 화살표 스타일 */");
            out.println(".arrow { border: solid #333; border-width: 0 2px 2px 0; display: inline-block; padding: 3px; }");
            out.println(".arrow.down { transform: rotate(45deg); -webkit-transform: rotate(45deg); }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<header class=\"header\">");
            out.println("<h1>중고 도서 목록</h1>");
            out.println("</header>");
            out.println("<main>");
            out.println("<div class=\"container\">");
            out.println("<nav class=\"category\">");
            out.println("<h2>카테고리</h2>");
            out.println("<ul>");

            // JDBC 드라이버 로드
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }

            // 데이터베이스 연결
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                // 카테고리 목록 가져오기
                String categorySQL = "SELECT DISTINCT category FROM Books";
                try (PreparedStatement pstmt = conn.prepareStatement(categorySQL);
                     ResultSet rs = pstmt.executeQuery()) {

                    while (rs.next()) {
                        String category = rs.getString("category");
                        out.println("<li class=\"category-item\">");
                        out.println("<button class=\"category-title\" onclick=\"toggleDropdown('" + category + "')\">");
                        out.println(category + " <i class=\"arrow down\"></i>");
                        out.println("</button>");
                        out.println("<ul id=\"" + category + "\" class=\"subcategory-list\">");

                        // 서브카테고리(중고 도서) 목록 가져오기
                        String usedBooksSQL = "SELECT * FROM Used_Books INNER JOIN Books ON Used_Books.book_id = Books.book_id WHERE Books.category = ?";
                        try (PreparedStatement pstmt2 = conn.prepareStatement(usedBooksSQL)) {
                            pstmt2.setString(1, category);
                            try (ResultSet usedBooksRS = pstmt2.executeQuery()) {
                                while (usedBooksRS.next()) {
                                    String bookTitle = usedBooksRS.getString("title");
                                    int price = usedBooksRS.getInt("price");
                                    String status = usedBooksRS.getString("status");
                                    String description = usedBooksRS.getString("description");
                                    out.println("<li>");
                                    out.println("<div class=\"book-info\">");
                                    out.println("<h3>" + bookTitle + "</h3>");
                                    out.println("<p>가격: " + price + " 원</p>");
                                    out.println("<p>상태: " + status + "</p>");
                                    out.println("<p>설명: " + description + "</p>");
                                    out.println("</div>");
                                    out.println("</li>");
                                }
                            }
                        }
                        out.println("</ul>");
                        out.println("</li>");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            out.println("</ul>");
            out.println("</nav>");
            out.println("</div>");
            out.println("</main>");
            out.println("<script>");
            out.println("function toggleDropdown(categoryId) {");
            out.println("    const dropdown = document.getElementById(categoryId);");
            out.println("    if (dropdown.style.display === \"block\") {");
            out.println("        dropdown.style.display = \"none\";");
            out.println("    } else {");
            out.println("        dropdown.style.display = \"block\";");
            out.println("    }");
            out.println("}");
            out.println("</script>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
