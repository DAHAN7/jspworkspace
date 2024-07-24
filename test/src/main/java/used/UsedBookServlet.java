package used;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/usedbooks")
@MultipartConfig
public class UsedBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/baskin";
    private static final String JDBC_USER = "digital";
    private static final String JDBC_PASSWORD = "1234";
    private static final String UPLOAD_DIR = "uploads"; // 파일 업로드 디렉토리

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        StringBuilder categoriesHtml = new StringBuilder();

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String categorySQL = "SELECT DISTINCT category FROM Books";
            try (PreparedStatement pstmt = conn.prepareStatement(categorySQL);
                 ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    String category = rs.getString("category");
                    categoriesHtml.append("<li class=\"category-item\">")
                        .append("<button class=\"category-title\" onclick=\"toggleDropdown('")
                        .append(category)
                        .append("')\">")
                        .append(category)
                        .append(" <i class=\"arrow down\"></i></button>")
                        .append("<ul id=\"")
                        .append(category)
                        .append("\" class=\"subcategory-list\">");

                    String usedBooksSQL = "SELECT B.title, B.author, B.price, B.publisher, B.description, B.category, UB.stock, UB.seller_id, B.image_path, UB.status " +
                                          "FROM Used_Books UB INNER JOIN Books B ON UB.book_id = B.book_id WHERE B.category = ?";
                    try (PreparedStatement pstmt2 = conn.prepareStatement(usedBooksSQL)) {
                        pstmt2.setString(1, category);
                        try (ResultSet usedBooksRS = pstmt2.executeQuery()) {
                            while (usedBooksRS.next()) {
                                String bookTitle = usedBooksRS.getString("title");
                                String author = usedBooksRS.getString("author");
                                int price = usedBooksRS.getInt("price");
                                String publisher = usedBooksRS.getString("publisher");
                                String description = usedBooksRS.getString("description");
                                int stock = usedBooksRS.getInt("stock");
                                String sellerId = usedBooksRS.getString("seller_id");
                                String imagePath = usedBooksRS.getString("image_path");
                                String status = usedBooksRS.getString("status");
                                categoriesHtml.append("<li class=\"subcategory-item\">")
                                    .append("<div class=\"book-info\">")
                                    .append("<h3>")
                                    .append(bookTitle)
                                    .append("</h3>")
                                    .append("<p>저자: ")
                                    .append(author)
                                    .append("</p>")
                                    .append("<p>가격: ")
                                    .append(price)
                                    .append(" 원</p>")
                                    .append("<p>출판사: ")
                                    .append(publisher)
                                    .append("</p>")
                                    .append("<p>상태: ")
                                    .append(status)
                                    .append("</p>")
                                    .append("<p>재고: ")
                                    .append(stock)
                                    .append("</p>")
                                    .append("<p>설명: ")
                                    .append(description)
                                    .append("</p>")
                                    .append("<p>판매자 ID: ")
                                    .append(sellerId)
                                    .append("</p>")
                                    .append("<img src=\"")
                                    .append(imagePath)
                                    .append("\" alt=\"책 표지\">")
                                    .append("</div>")
                                    .append("</li>");
                            }
                        }
                    }
                    categoriesHtml.append("</ul></li>");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"en\">");
            out.println("<head>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<title>중고 도서 판매</title>");
            out.println("<link rel=\"stylesheet\" href=\"/test/used/style.css\">");
            out.println("</head>");
            out.println("<body>");
            out.println("<header class=\"header\">");
            out.println("<h1>중고샵</h1>");
            out.println("<p>해외 직배송 도서 모음!</p>");
            out.println("</header>");
            out.println("<main>");
            out.println("<div class=\"container\">");
            out.println("<nav class=\"category\">");
            out.println("<h2>카테고리</h2>");
            out.println("<ul>");
            out.println(categoriesHtml.toString());
            out.println("</ul>");
            out.println("</nav>");
            out.println("<section class=\"used-book-upload\">");
            out.println("<h2>중고 도서 판매</h2>");
            out.println("<p>판매하실 도서의 정보를 입력해주세요.</p>");
            out.println("<form id=\"used-book-form\" action=\"/usedbooks\" method=\"post\" enctype=\"multipart/form-data\">");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-title\">도서명:</label>");
            out.println("<input type=\"text\" id=\"book-title\" name=\"book-title\" required>");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-author\">저자:</label>");
            out.println("<input type=\"text\" id=\"book-author\" name=\"book-author\" required>");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-price\">판매 가격:</label>");
            out.println("<input type=\"number\" id=\"book-price\" name=\"book-price\" min=\"1000\" required> 원");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-condition\">도서 상태:</label>");
            out.println("<select id=\"book-condition\" name=\"book-condition\" required>");
            out.println("<option value=\"최상\">최상</option>");
            out.println("<option value=\"상\">상</option>");
            out.println("<option value=\"중\">중</option>");
            out.println("<option value=\"하\">하</option>");
            out.println("</select>");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-description\">상세 설명:</label>");
            out.println("<textarea id=\"book-description\" name=\"book-description\"></textarea>");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-images\">사진 업로드:</label>");
            out.println("<input type=\"file\" id=\"book-images\" name=\"book-images\" multiple accept=\"image/*\">");
            out.println("</div>");
            out.println("<button type=\"submit\" class=\"submit-button\">판매 등록</button>");
            out.println("</form>");
            out.println("</section>");
            out.println("</div>");
            out.println("</main>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // 업로드 디렉토리 생성
        File uploadDir = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // 폼 데이터와 파일 처리
            String title = request.getParameter("book-title");
            String author = request.getParameter("book-author");
            int price = Integer.parseInt(request.getParameter("book-price"));
            String condition = request.getParameter("book-condition");
            String description = request.getParameter("book-description");

            // 업로드된 파일 처리
            Collection<Part> parts = request.getParts();
            String imagePath = null;

            for (Part part : parts) {
                if (part.getContentType() != null && part.getContentType().startsWith("image/")) {
                    String fileName = extractFileName(part);
                    String filePath = uploadDir + File.separator + fileName;
                    part.write(filePath);
                    imagePath = UPLOAD_DIR + "/" + fileName;
                }
            }

            // 데이터베이스에 저장
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                String insertSQL = "INSERT INTO Used_Books (title, author, price, condition, description, image_path) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {
                    pstmt.setString(1, title);
                    pstmt.setString(2, author);
                    pstmt.setInt(3, price);
                    pstmt.setString(4, condition);
                    pstmt.setString(5, description);
                    pstmt.setString(6, imagePath);
                    pstmt.executeUpdate();
                }
            }

            // 성공 메시지 출력
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body>");
                out.println("<h2>도서 판매 등록이 완료되었습니다.</h2>");
                out.println("<a href=\"/usedbooks\">돌아가기</a>");
                out.println("</body></html>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body>");
                out.println("<h2>도서 판매 등록 중 오류가 발생했습니다.</h2>");
                out.println("<a href=\"/usedbooks\">돌아가기</a>");
                out.println("</body></html>");
            }
        }
    }

    // 파일 이름 추출
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("Content-Disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
