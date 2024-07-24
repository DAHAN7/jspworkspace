package usedlist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/loadBooks")
public class LoadBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 데이터베이스 연결 정보
    private static final String DB_URL = "jdbc:mysql://localhost:3306/baskin";
    private static final String DB_USER = "digital";
    private static final String DB_PASSWORD = "1234";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 콘텐츠 타입 설정
        response.setContentType("text/html;charset=UTF-8");
        
        // HTML 작성
        PrintWriter out = response.getWriter();

        // 데이터베이스 연결 및 쿼리 실행
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 데이터베이스 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 데이터베이스 연결
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL 쿼리
            String sql = "SELECT * FROM books"; // 모든 책 정보를 조회
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // 결과를 HTML 테이블로 작성
            out.println("<html><body>");
            out.println("<h1>도서 목록</h1>");
            out.println("<table border='1'>");
            out.println("<tr><th>ID</th><th>제목</th><th>저자</th><th>가격</th><th>출판사</th><th>설명</th><th>카테고리</th><th>재고</th><th>이미지</th></tr>");

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("book_id") + "</td>");
                out.println("<td>" + rs.getString("title") + "</td>");
                out.println("<td>" + rs.getString("author") + "</td>");
                out.println("<td>" + rs.getDouble("price") + "</td>");
                out.println("<td>" + rs.getString("publisher") + "</td>");
                out.println("<td>" + rs.getString("description") + "</td>");
                out.println("<td>" + rs.getString("category") + "</td>");
                out.println("<td>" + rs.getInt("stock") + "</td>");
                out.println("<td><img src='" + rs.getString("image") + "' alt='Book Image' width='100' height='150'></td>");
                out.println("</tr>");
            }

            out.println("</table>");
            out.println("</body></html>");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "JDBC 드라이버 로드 오류: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터베이스 오류: " + e.getMessage());
        } finally {
            // 자원 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
