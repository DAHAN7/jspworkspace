package used;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/usedbooks")
public class UsedBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/baskin";
    private static final String JDBC_USER = "digital";
    private static final String JDBC_PASSWORD = "1234";

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

                    String usedBooksSQL = "SELECT * FROM Used_Books INNER JOIN Books ON Used_Books.book_id = Books.book_id WHERE Books.category = ?";
                    try (PreparedStatement pstmt2 = conn.prepareStatement(usedBooksSQL)) {
                        pstmt2.setString(1, category);
                        try (ResultSet usedBooksRS = pstmt2.executeQuery()) {
                            while (usedBooksRS.next()) {
                                String bookTitle = usedBooksRS.getString("title");
                                int price = usedBooksRS.getInt("price");
                                String status = usedBooksRS.getString("status");
                                String description = usedBooksRS.getString("description");
                                categoriesHtml.append("<li class=\"subcategory-item\">")
                                    .append("<div class=\"book-info\">")
                                    .append("<h3>")
                                    .append(bookTitle)
                                    .append("</h3>")
                                    .append("<p>가격: ")
                                    .append(price)
                                    .append(" 원</p>")
                                    .append("<p>상태: ")
                                    .append(status)
                                    .append("</p>")
                                    .append("<p>설명: ")
                                    .append(description)
                                    .append("</p>")
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
            out.println("<title>중고 도서 판매 - 배스킨라빈스31.2</title>");
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
            out.println("<form id=\"used-book-form\">");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-search\">도서 검색:</label>");
            out.println("<div class=\"search-bar\">");
            out.println("<input type=\"text\" id=\"book-search\" placeholder=\"도서명 또는 ISBN 입력\">");
            out.println("<button type=\"button\" id=\"search-button\">검색</button>");
            out.println("</div>");
            out.println("</div>");
            out.println("<div id=\"book-info\" style=\"display: none;\">");
            out.println("<div class=\"book-image\">");
            out.println("<img id=\"book-cover\" src=\"\" alt=\"책 표지\">");
            out.println("</div>");
            out.println("<div class=\"book-details\">");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-title\">도서명:</label>");
            out.println("<input type=\"text\" id=\"book-title\" readonly>");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-author\">저자:</label>");
            out.println("<input type=\"text\" id=\"book-author\" readonly>");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-isbn\">ISBN:</label>");
            out.println("<input type=\"text\" id=\"book-isbn\" readonly>");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-price\">판매 가격:</label>");
            out.println("<input type=\"number\" id=\"book-price\" min=\"1000\" required> 원");
            out.println("</div>");
            out.println("<div class=\"form-row\">");
            out.println("<label for=\"book-condition\">도서 상태:</label>");
            out.println("<select id=\"book-condition\" name=\"book-condition\">");
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
            out.println("</div>");
            out.println("</div>");
            out.println("</form>");
            out.println("<div class=\"selling-info\">");
            out.println("<h3>소장하고 계신 중고 상품을 실속있게 판매해 보세요!</h3>");
            out.println("<div class=\"selling-options\">");
            out.println("<div class=\"selling-option\">");
            out.println("<img src=\"buyback.png\" alt=\"바이백\">");
            out.println("<p>배스킨라빈스에 팔기</p>");
            out.println("</div>");
            out.println("<div class=\"selling-option\">");
            out.println("<img src=\"my-store.png\" alt=\"내 가게\">");
            out.println("<p>내 가게에서 팔기</p>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</section>");
            out.println("<section class=\"popular-books\">");
            out.println("<h2>인기 중고도서 상품</h2>");
            out.println("<article class=\"book-item\">");
            out.println("<img src=\"book1.jpg\" alt=\"Book 1\">");
            out.println("<h3>Book 1 Title</h3>");
            out.println("<p>Author: 최기근</p>");
            out.println("<p>Price: $90.00</p>");
            out.println("</article>");
            out.println("<article class=\"book-item\">");
            out.println("<img src=\"book2.jpg\" alt=\"Book 2\">");
            out.println("<h3>Book 2 Title</h3>");
            out.println("<p>Author: 최기근</p>");
            out.println("<p>Price: $25.00</p>");
            out.println("</article>");
            out.println("<article class=\"book-item\">");
            out.println("<img src=\"book3.jpg\" alt=\"Book 3\">");
            out.println("<h3>Book 3 Title</h3>");
            out.println("<p>Author: 최기근</p>");
            out.println("<p>Price: $20.00</p>");
            out.println("</article>");
            out.println("<article class=\"book-item\">");
            out.println("<img src=\"book4.jpg\" alt=\"Book 4\">");
            out.println("<h3>Book 4 Title</h3>");
            out.println("<p>Author: 최기근</p>");
            out.println("<p>Price: $33.00</p>");
            out.println("</article>");
            out.println("<article class=\"book-item\">");
            out.println("<img src=\"book5.jpg\" alt=\"Book 5\">");
            out.println("<h3>Book 5 Title</h3>");
            out.println("<p>Author: 최기근</p>");
            out.println("<p>Price: $40.00</p>");
            out.println("</article>");
            out.println("</section>");
            out.println("</div>");
            out.println("</main>");
            out.println("<footer class=\"footer\">");
            out.println("<div class=\"footer-info\">");
            out.println("<h4>회사 정보</h4>");
            out.println("<p>중고도서, 도서관, 주식회사 중고도서</p>");
            out.println("<p>대표자: 최기근</p>");
            out.println("<p>사업자등록번호: 123-45-67890</p>");
            out.println("</div>");
            out.println("</footer>");
            out.println("<script src=\"/test/used/scripts.js\"></script>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 여기에 도서 판매 등록 로직을 추가할 수 있습니다.
    }
}
