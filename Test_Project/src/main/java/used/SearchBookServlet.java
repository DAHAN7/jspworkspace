package used;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/searchBookServlet")
public class SearchBookServlet extends HttpServlet {
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/MySQLDB"); // 실제 JNDI 이름으로 변경 필요
        } catch (NamingException e) {
            throw new ServletException("Failed to initialize DataSource", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");

        response.setContentType("text/html;charset=UTF-8");

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM books WHERE title LIKE ?");
             PrintWriter out = response.getWriter()) {

            stmt.setString(1, "%" + title + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    out.println("<div class='book-item'>");
                    out.println("<p>도서명: " + rs.getString("title") + "</p>");
                    out.println("<p>저자: " + rs.getString("author") + "</p>");
                    out.println("<button onclick='registerBook(\"" + rs.getString("title") + "\", \"" + rs.getString("author") + "\")'>등록</button>");
                    out.println("</div>");
                }
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred: " + e.getMessage());
        }
    }
}
