<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.IOException" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>상태 변경</title>
</head>
<body>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int memberNum = 1; // 관리자가 적립금을 추가할 회원 번호

        String orderGroupId = request.getParameter("order_group_id");
        String newStatus = request.getParameter("status");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/baskin";
            String user = "root";
            String password = "1234";
            conn = DriverManager.getConnection(url, user, password);

            conn.setAutoCommit(false); // 트랜잭션 시작

            // 주문 상태 업데이트 쿼리
            String updateStatusQuery = "UPDATE Orders SET status = ? WHERE order_group_id = ?";
            pstmt = conn.prepareStatement(updateStatusQuery);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, Integer.parseInt(orderGroupId));
            pstmt.executeUpdate();

            // 배송 완료 상태일 때 금액 추가 쿼리
            if ("배송 완료".equals(newStatus)) {
                String totalPriceQuery = "SELECT SUM(total_price) FROM Orders WHERE order_group_id = ?";
                pstmt = conn.prepareStatement(totalPriceQuery);
                pstmt.setInt(1, Integer.parseInt(orderGroupId));
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    int totalPrice = rs.getInt(1);
                    
                    // 회원의 금액 추가 쿼리
                    String updateMemberQuery = "UPDATE member SET money = money + ? WHERE memberNum = ?";
                    pstmt = conn.prepareStatement(updateMemberQuery);
                    pstmt.setInt(1, totalPrice);
                    pstmt.setInt(2, memberNum);
                    pstmt.executeUpdate();
                }
            }

            conn.commit(); // 트랜잭션 커밋
            response.sendRedirect("orderManagement.jsp"); // 주문 관리 페이지로 리디렉션

        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
</body>
</html>
