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
    private static final String DB_USER = "used";
    private static final String DB_PASSWORD = "1234";
    private static final String UPLOAD_DIR = "/path/to/upload/directory"; 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // 폼 데이터 처리
        String bookId = request.getParameter("book_id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String priceStr = request.getParameter("price");
        String bookMemo = request.getParameter("book_memo");
        String newOldEbook = request.getParameter("new_old_ebook");
        String stockStr = request.getParameter("stock");
        String sellerIdStr = request.getParameter("seller_id");
        String categoryOverseas = request.getParameter("category_overseas");
        String categoryAge = request.getParameter("category_age");
        String categoryAll = request.getParameter("category_all");
        Part bookImagePart = request.getPart("book_fileName");

        // 데이터 유효성 검사
        if (bookId == null || title == null || author == null || publisher == null || priceStr == null ||
            stockStr == null || sellerIdStr == null || newOldEbook == null || categoryOverseas == null || 
            categoryAll == null) {
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
            out.print("{\"success\": false, \"message\": \"유효하지 않은 숫자 형식입니다.\"}");
            out.flush();
            return;
        }

        // 파일 저장 경로 생성
        String bookImageFileName = extractFileName(bookImagePart);
        if (bookImageFileName != null && !bookImageFileName.isEmpty()) {
            String bookImageFilePath = UPLOAD_DIR + File.separator + bookImageFileName;

            // 파일 저장
            try (InputStream input = bookImagePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(bookImageFilePath)) {

                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                out.print("{\"success\": false, \"message\": \"파일 저장 중 오류 발생: " + e.getMessage() + "\"}");
                out.flush();
                return;
            }
        }

        // 데이터베이스 저장
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO books (book_id, title, author, publisher, price, book_memo, new_old_ebook, stock, seller_id, category_overseas, category_age, category_all, book_fileName) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {
            pstmt.setString(1, bookId);
            pstmt.setString(2, title);
            pstmt.setString(3, author);
            pstmt.setString(4, publisher);
            pstmt.setInt(5, price);
            pstmt.setString(6, bookMemo);
            pstmt.setString(7, newOldEbook);
            pstmt.setInt(8, stock);
            pstmt.setInt(9, sellerId);
            pstmt.setString(10, categoryOverseas);
            pstmt.setString(11, categoryAge);
            pstmt.setString(12, categoryAll);
            pstmt.setString(13, bookImageFileName);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"도서 등록에 실패하였습니다.\"}");
            }
        } catch (SQLException e) {
            handleSQLException(response, e);
        } finally {
            out.flush();
        }
    }

    private void handleSQLException(HttpServletResponse response, SQLException e) throws IOException {
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
