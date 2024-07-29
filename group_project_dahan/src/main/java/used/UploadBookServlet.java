package used;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/UploadBookServlet")
@MultipartConfig
public class UploadBookServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/baskin";
    private static final String DB_USER = "man";
    private static final String DB_PASSWORD = "1234";
    private static final String UPLOAD_DIR = "/path/to/upload/directory"; // 서버에 파일을 저장할 경로

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 폼 데이터 처리
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String stockStr = request.getParameter("stock");
        String sellerIdStr = request.getParameter("seller_id");
        String status = request.getParameter("status");

        Part coverImagePart = request.getPart("image_path");

        // 데이터 유효성 검사
        if (title == null || author == null || priceStr == null || description == null || category == null || stockStr == null || sellerIdStr == null || status == null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"message\": \"필수 데이터가 부족합니다.\"}");
            out.flush();
            return;
        }

        int price;
        int stock;
        int sellerId;
        try {
            price = Integer.parseInt(priceStr);
            stock = Integer.parseInt(stockStr);
            sellerId = Integer.parseInt(sellerIdStr);
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": false, \"message\": \"유효하지 않은 숫자 형식입니다.\"}");
            out.flush();
            return;
        }

        // 파일 저장 경로 생성
        String coverImageFileName = extractFileName(coverImagePart);
        String coverImageFilePath = UPLOAD_DIR + File.separator + coverImageFileName;

        // 파일 저장
        if (coverImageFileName != null && !coverImageFileName.isEmpty()) {
            try (InputStream input = coverImagePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(coverImageFilePath)) {
                
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
        }

        // 데이터베이스 저장
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO books (title, author, publisher, price, description, category, stock, seller_id, image_path, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, title);
                pstmt.setString(2, author);
                pstmt.setString(3, publisher);
                pstmt.setInt(4, price);
                pstmt.setString(5, description);
                pstmt.setString(6, category);
                pstmt.setInt(7, stock);
                pstmt.setInt(8, sellerId);
                pstmt.setString(9, coverImageFileName);
                pstmt.setString(10, status);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print("{\"success\": true}");
                    out.flush();
                } else {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print("{\"success\": false, \"message\": \"도서 등록에 실패하였습니다.\"}");
                    out.flush();
                }
            } catch (SQLException e) {
                handleSQLException(response, e);
            }
        } catch (SQLException e) {
            handleSQLException(response, e);
        }
    }

    private void handleSQLException(HttpServletResponse response, SQLException e) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": false, \"message\": \"데이터베이스 오류: " + e.getMessage() + "\"}");
        out.flush();
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("Content-Disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
