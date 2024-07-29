package used;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.google.gson.Gson;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet("/uploadBook")
@MultipartConfig
public class BookUploadServlet extends HttpServlet {

    // 데이터베이스 연결 정보
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/used_bookstore?serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234"; // 실제 비밀번호로 변경

    // 파일 업로드 경로
    private static final String UPLOAD_PATH = "/uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 응답의 콘텐츠 타입 설정
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        // 폼 데이터 가져오기
        String title = request.getParameter("book-title");
        String author = request.getParameter("book-author");
        String isbn = request.getParameter("book-isbn");
        int price = Integer.parseInt(request.getParameter("book-price"));
        String condition = request.getParameter("book-condition");
        String description = request.getParameter("book-description");
        String category = request.getParameter("category");

        List<String> imagePaths = new ArrayList<>();

        // 파일 업로드 처리
        Collection<Part> parts = request.getParts();
        for (Part part : parts) {
            if (part.getName().startsWith("book-images") && part.getSize() > 0) {
                String fileName = getSubmittedFileName(part);
                String filePath = getServletContext().getRealPath(UPLOAD_PATH) + File.separator + fileName;
                try (InputStream input = part.getInputStream()) {
                    Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                }
                imagePaths.add(UPLOAD_PATH + "/" + fileName);
            }
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            conn.setAutoCommit(false); // 트랜잭션 시작

            try {
                // 데이터베이스에 데이터 삽입
                String sql = "INSERT INTO books (title, author, isbn, price, condition, description, category, images) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setString(1, title);
                    stmt.setString(2, author);
                    stmt.setString(3, isbn);
                    stmt.setInt(4, price);
                    stmt.setString(5, condition);
                    stmt.setString(6, description);
                    stmt.setString(7, category);
                    stmt.setString(8, String.join(",", imagePaths));
                    stmt.executeUpdate();

                    // 생성된 book_id 가져오기 (Auto Increment)
                    ResultSet generatedKeys = stmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int bookId = generatedKeys.getInt(1);

                        // 이미지 경로 업데이트 (book_id 포함)
                        updateImagePaths(conn, bookId, imagePaths, request);
                    }

                    conn.commit(); // 트랜잭션 커밋
                    out.print("{\"result\": \"success\"}");
                }
            } catch (SQLException e) {
                conn.rollback(); // 트랜잭션 롤백
                out.print("{\"result\": \"error\", \"message\": \"Database error: " + e.getMessage() + "\"}");
            }
        } catch (Exception e) {
            out.print("{\"result\": \"error\", \"message\": \"File upload or processing error: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String category = request.getParameter("category"); // 카테고리 정보 가져오기
        int page = Integer.parseInt(request.getParameter("page"));
        int itemsPerPage = 4;
        int offset = (page - 1) * itemsPerPage;

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            // 전체 아이템 수 가져오기 (카테고리별)
            String countSql = "SELECT COUNT(*) FROM books WHERE category = ?";
            try (PreparedStatement countStmt = conn.prepareStatement(countSql)) {
                countStmt.setString(1, category);
                try (ResultSet rs = countStmt.executeQuery()) {
                    rs.next();
                    int totalItems = rs.getInt(1);
                    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

                    // 페이징 처리된 데이터 가져오기 (카테고리별)
                    String sql = "SELECT * FROM books WHERE category = ? LIMIT ?, ?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setString(1, category);
                        stmt.setInt(2, offset);
                        stmt.setInt(3, itemsPerPage);
                        try (ResultSet rs2 = stmt.executeQuery()) {
                            List<Book> books = new ArrayList<>();
                            while (rs2.next()) {
                                int bookId = rs2.getInt("book_id");
                                String title = rs2.getString("title");
                                String author = rs2.getString("author");
                                String isbn = rs2.getString("isbn");
                                int price = rs2.getInt("price");
                                String condition = rs2.getString("condition");
                                String description = rs2.getString("description");
                                String[] images = rs2.getString("images").split(",");

                                books.add(new Book(bookId, title, author, isbn, price, condition, description, images));
                            }

                            // JSON 응답 생성
                            String jsonResponse = new Gson().toJson(books);
                            jsonResponse = "{\"totalItems\":" + totalItems + ", \"totalPages\":" + totalPages + ", \"books\":" + jsonResponse + "}";
                            out.print(jsonResponse);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            out.print("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        }
    }

    // 이미지 경로 업데이트 메서드
    private void updateImagePaths(Connection conn, int bookId, List<String> imagePaths, HttpServletRequest request) throws SQLException, IOException, ServletException {
        for (int i = 0; i < imagePaths.size(); i++) {
            String oldImagePath = imagePaths.get(i);
            String newFileName = bookId + "_" + getSubmittedFileName(request.getPart("book-images-" + (i + 1)));
            String newImagePath = UPLOAD_PATH + "/" + newFileName;
            imagePaths.set(i, newImagePath);

            // 이미지 파일 이름 변경
            File oldFile = new File(getServletContext().getRealPath(oldImagePath));
            File newFile = new File(getServletContext().getRealPath(newImagePath));
            oldFile.renameTo(newFile);
        }

        // 업데이트된 이미지 경로를 데이터베이스에 저장
        String sql = "UPDATE books SET images = ? WHERE book_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, String.join(",", imagePaths));
            stmt.setInt(2, bookId);
            stmt.executeUpdate();
        }
    }

    // 파일 이름 추출 함수
    private static String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }

    // Book 클래스 정의
    private static class Book {
        int bookId;
        String title;
        String author;
        String isbn;
        int price;
        String condition;
        String description;
        String[] images;

        public Book(int bookId, String title, String author, String isbn, int price, String condition, String description, String[] images) {
            this.bookId = bookId;
            this.title = title;
            this.author = author;
            this.isbn = isbn;
            this.price = price;
            this.condition = condition;
            this.description = description;
            this.images = images;
        }
    }
}
