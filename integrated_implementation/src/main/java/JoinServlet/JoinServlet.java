package JoinServlet;

import dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JoinServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/digital_jsp";
    private static final String JDBC_USER = "digital";
    private static final String JDBC_PASSWORD = "1234";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String pass = request.getParameter("pass");
        String name = request.getParameter("name");
        String addr = request.getParameter("addr");
        String phone = request.getParameter("phone");

        MemberDTO member = new MemberDTO();
        member.setId(id);
        member.setPass(pass);
        member.setName(name);
        member.setAddr(addr);
        member.setPhone(phone);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String checkSql = "SELECT COUNT(*) FROM tbl_member WHERE id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, member.getId());
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
              
                out.println("<script>");
                out.println("alert('회원아이디가 이미 존재합니다.');");
                out.println("history.go(-1);");
                out.println("</script>");
            } else {
                // 새로운 회원 등록
                String insertSql = "INSERT INTO tbl_member (id, pass, name, addr, phone) VALUES (?, ?, ?, ?, ?)";
                pstmt.close(); 
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, member.getId());
                pstmt.setString(2, member.getPass());
                pstmt.setString(3, member.getName());
                pstmt.setString(4, member.getAddr());
                pstmt.setString(5, member.getPhone());
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    // 회원가입 성공
                    out.println("<script>");
                    out.println("alert('회원가입이 성공적으로 처리되었습니다.');");
                    out.println("location.href='main.jsp';");
                    out.println("</script>");
                } else {
                    // 회원가입 실패
                    out.println("<script>");
                    out.println("alert('회원가입에 실패했습니다. 다시 시도해 주세요.');");
                    out.println("history.go(-1);"); // 이전 페이지로 돌아가기
                    out.println("</script>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>");
            out.println("alert('서버 오류가 발생했습니다. 관리자에게 문의하세요.');");
            out.println("history.go(-1);"); // 이전 페이지로 돌아가기
            out.println("</script>");
        } finally {
            // 자원 정리
            try { if (rs != null) rs.close(); } catch (Exception e) { /* ignored */ }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { /* ignored */ }
            try { if (conn != null) conn.close(); } catch (Exception e) { /* ignored */ }
            out.close();
        }
    }
}
