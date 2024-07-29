package used;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerBook")
public class RegisterBookServlet extends HttpServlet {
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

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");
            String sql = "INSERT INTO books (title, author, publisher, price, status, description, category, stock, image_path, seller_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        response.sendRedirect("bookRegistrationSuccess.jsp");
    }
}
