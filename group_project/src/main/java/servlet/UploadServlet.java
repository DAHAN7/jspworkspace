package servlet;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String url = "jdbc:mysql://localhost:3306/baskin";
        String user = "root";
        String password = "1234";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try (PrintWriter out = response.getWriter()) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            int price = Integer.parseInt(request.getParameter("price"));
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            int stock = Integer.parseInt(request.getParameter("stock"));
            String status = "신책"; // 고정 값
            int seller_id = 1; // 고정 값

            String savePath = getServletContext().getRealPath("/upload");
            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }

            String fileName = null;
            Part filePart = request.getPart("book_Image");
            if (filePart != null) {
                fileName = filePart.getSubmittedFileName();
                filePart.write(savePath + File.separator + fileName);
            }

            String sql = "INSERT INTO Books (title, author, publisher, price, description, category, stock, seller_id, status, image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, author);
            pstmt.setString(3, publisher);
            pstmt.setInt(4, price);
            pstmt.setString(5, description);
            pstmt.setString(6, category);
            pstmt.setInt(7, stock);
            pstmt.setInt(8, seller_id); // 고정 값 설정
            pstmt.setString(9, status);
            pstmt.setString(10, fileName != null ? "upload/" + fileName : null);
            
            int result = pstmt.executeUpdate();
            if (result > 0) {
                out.println("상품이 성공적으로 등록되었습니다.");
                response.sendRedirect("insert_form.jsp");
            } else {
                out.println("상품 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("오류가 발생했습니다: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
