package used;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> books = new ArrayList<>(); // new 추가
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 데이터베이스 연결
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM books";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // 결과를 리스트에 담기
            while (rs.next()) {
                Book book = new Book();
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setImage(rs.getString("image"));
                book.setPublisher(rs.getString("publisher"));
                book.setYear(rs.getString("year"));
                book.setMinPrice(rs.getDouble("minPrice")); 
                book.setMaxPrice(rs.getDouble("maxPrice")); 
                book.setSalePrice(rs.getDouble("salePrice")); 
                book.setSalePercent(rs.getDouble("salePercent"));
                book.setTotalUsed(rs.getInt("totalUsed")); 
                book.setBaskin31_2Used(rs.getInt("baskin31_2Used")); 
                book.setSellerUsed(rs.getInt("sellerUsed")); 

                books.add(book);
            }

            // JSP로 데이터 전달
            request.setAttribute("books", books);
            request.getRequestDispatcher("/books.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제 순서 개선
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                DBUtil.close(conn);
            }
        }
    }
}

// DBUtil 클래스 (예시)
class DBUtil {
    public static Connection getConnection() {
        // 데이터베이스 연결 코드 작성
        return null; // 실제 연결 객체 반환
    }

    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
