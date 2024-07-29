package used;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/searchBookServlet")
public class SearchBookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PrintWriter out = response.getWriter();

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "man", "1234");
            String sql = "SELECT * FROM books WHERE title LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + title + "%");
            rs = stmt.executeQuery();

            while (rs.next()) {
                out.println("<div class='book-item'>");
                out.println("<p>도서명: " + rs.getString("title") + "</p>");
                out.println("<p>저자: " + rs.getString("author") + "</p>");
                out.println("<button onclick='registerBook(\"" + rs.getString("title") + "\", \"" + rs.getString("author") + "\")'>등록</button>");
                out.println("</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
