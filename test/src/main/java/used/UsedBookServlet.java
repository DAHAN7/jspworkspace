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

    // 데이터베이스 연결 정보
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/digital_jsp";
    private static final String JDBC_USER = "digital";
    private static final String JDBC_PASSWORD = "1234";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // 카테고리 및 도서 정보를 저장할 변수
        StringBuilder categoriesHtml = new StringBuilder();

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            // 카테고리 목록 쿼리
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

                    // 서브카테고리(중고 도서) 목록 쿼리
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

        // HTML 응답 생성
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
            out.println("<option value=\"best\">최상</option>");
            out.println("<option value=\"good\">상</option>");
            out.println("<option value=\"fair\">중</option>");
            out.println("<option value=\"poor\">하</option>");
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
            out.println("<p>Price: $85.00</p>");
            out.println("</article>");
            out.println("</section>");
            out.println("<section class=\"store-section\">");
            out.println("<h2>추천 헌책방</h2>");
            out.println("<div class=\"store-list\">");
            out.println("<article class=\"store-item\">");
            out.println("<h3>베스킨 헌책방</h3>");
            out.println("<img src=\"store1.jpg\" alt=\"베스킨 헌책방\">");
            out.println("<p>30,000원 이상 무료배송</p>");
            out.println("<p>판매자: 최기근</p>");
            out.println("</article>");
            out.println("<article class=\"store-item\">");
            out.println("<h3>JSP</h3>");
            out.println("<img src=\"store2.jpg\" alt=\"JSP\">");
            out.println("<p>100,000원 이상 무료배송</p>");
            out.println("<p>판매자: 최기근</p>");
            out.println("</article>");
            out.println("<article class=\"store-item\">");
            out.println("<h3>HTML</h3>");
            out.println("<img src=\"store3.jpg\" alt=\"HTML\">");
            out.println("<p>25,000원 이상 무료배송</p>");
            out.println("<p>판매자: 최기근</p>");
            out.println("</article>");
            out.println("<article class=\"store-item\">");
            out.println("<h3>스프링</h3>");
            out.println("<img src=\"store4.jpg\" alt=\"스프링\">");
            out.println("<p>70,000원 이상 무료배송</p>");
            out.println("<p>판매자: 최기근</p>");
            out.println("</article>");
            out.println("<article class=\"store-item\">");
            out.println("<h3>CSS</h3>");
            out.println("<img src=\"store5.jpg\" alt=\"CSS\">");
            out.println("<p>30,000원 이상 무료배송</p>");
            out.println("<p>판매자: 최기근</p>");
            out.println("</article>");
            out.println("</div>");
            out.println("</section>");
            out.println("<section class=\"special-section\">");
            out.println("<article class=\"special-item\">");
            out.println("<h2>부산IT 직배송 중고</h2>");
            out.println("<p>싸고 믿을 수 있고 총알배송까지!<br>부산IT 직배송 중고도서 둘러보세요!</p>");
            out.println("<img src=\"book1.jpg\" alt=\"부트스트랩\">");
            out.println("<p>부트스트랩</p>");
            out.println("<p>15000원</p>");
            out.println("<p>새상품 대비 33% 할인</p>");
            out.println("</article>");
            out.println("<article class=\"special-item\">");
            out.println("<h2>소장용 상품</h2>");
            out.println("<p>소장가치가 높은 특별한 중고상품을<br>만나보세요!</p>");
            out.println("<img src=\"book2.jpg\" alt=\"파이썬\">");
            out.println("<p>파이썬</p>");
            out.println("<p>제어문 컬렉션</p>");
            out.println("<p>45,000원</p>");
            out.println("</article>");
            out.println("<article class=\"special-item\">");
            out.println("<h2>중고상품 판매요청</h2>");
            out.println("<p>찾는 상품이 중고샵에 없나요?<br>원하는 중고상품을 요청해주세요!</p>");
            out.println("<img src=\"book3.jpg\" alt=\"홈(1Disc)\">");
            out.println("<p>홈(1Disc)</p>");
            out.println("<p>요청건수: 99건</p>");
            out.println("</article>");
            out.println("</section>");
            out.println("</div>");
            out.println("</main>");
            out.println("<script src=\"/test/used/script.js\"></script>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
