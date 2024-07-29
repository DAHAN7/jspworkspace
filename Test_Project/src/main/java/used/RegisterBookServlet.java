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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/registerBookServlet")
public class RegisterBookServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(RegisterBookServlet.class.getName());
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/MySQLDB"); // JNDI 이름을 실제 데이터 소스 이름으로 변경
        } catch (NamingException e) {
            throw new ServletException("JNDI Lookup Failure", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        int price = Integer.parseInt(request.getParameter("price"));
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imagePath = request.getParameter("image_path");
        int sellerId = Integer.parseInt(request.getParameter("seller_id"));

        String sql = "INSERT INTO books (title, author, publisher, price, status, description, category, stock, image_path, seller_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, publisher);
            stmt.setInt(4, price);
            stmt.setString(5, status);
            stmt.setString(6, description);
            stmt.setString(7, category);
            stmt.setInt(8, stock);
            stmt.setString(9, imagePath);
            stmt.setInt(10, sellerId);

            stmt.executeUpdate();
            logger.log(Level.INFO, "Book registered successfully: {0}", title);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error registering book: {0}", e.getMessage());
            response.sendRedirect("bookRegistrationError.jsp");
            return;
        }

        response.sendRedirect("bookRegistrationSuccess.jsp");
    }
}
