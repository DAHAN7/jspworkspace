package usedlist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

@WebServlet("/loadBooks")
public class LoadBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 데이터베이스 연결 정보
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/baskin");
        } catch (NamingException e) {
            throw new ServletException("Cannot retrieve JDBC DataSource", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            // SQL 쿼리
            String sql = "SELECT book_id, title, author, price, publisher, book_memo AS description, " +
                         "category_overseas AS category, stock, book_fileName AS image_path, new_old_ebook AS status " +
                         "FROM books";

            try (Connection conn = dataSource.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {

                out.println("<html><head>");
                out.println("<title>도서 목록</title>");
                out.println("<style>");
                out.println("table { width: 100%; border-collapse: collapse; }");
                out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }");
                out.println("th { background-color: #f2f2f2; }");
                out.println("img { max-width: 100px; max-height: 150px; }");
                out.println("</style>");
                out.println("</head><body>");
                out.println("<h1>도서 목록</h1>");
                out.println("<table>");
                out.println("<tr><th>ID</th><th>제목</th><th>저자</th><th>가격</th><th>출판사</th><th>설명</th><th>카테고리</th><th>재고</th><th>이미지</th><th>상태</th></tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("book_id") + "</td>");
                    out.println("<td>" + rs.getString("title") + "</td>");
                    out.println("<td>" + rs.getString("author") + "</td>");
                    out.println("<td>" + rs.getInt("price") + "</td>");
                    out.println("<td>" + rs.getString("publisher") + "</td>");
                    out.println("<td>" + rs.getString("description") + "</td>");
                    out.println("<td>" + rs.getString("category") + "</td>");
                    out.println("<td>" + rs.getInt("stock") + "</td>");
                    out.println("<td><img src='" + (rs.getString("image_path") != null ? rs.getString("image_path") : "/path/to/default/image.jpg") + "' alt='Book Image'></td>");
                    out.println("<td>" + rs.getString("status") + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");
                out.println("</body></html>");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터베이스 오류: " + e.getMessage());
            }
        }
    }
}
