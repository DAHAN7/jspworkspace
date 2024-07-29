<%@page import="java.sql.*, utils.JDBCUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(request.getMethod().equalsIgnoreCase("POST")){
        
        String impUid = request.getParameter("imp_uid");
        String merchantUid = request.getParameter("merchant_uid");
        int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
        String applyNum = request.getParameter("apply_num");
        String buyerName = request.getParameter("buyer_name");
        String buyerTel = request.getParameter("buyer_tel");
        String buyerAddr = request.getParameter("buyer_addr");
        
        int memberNum = 1; // 실제로는 세션이나 쿠키에서 가져옴
        ResultSet rs = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        int orderGroupId = 0;
        
        try {
            conn = JDBCUtil.getConnection();
            
            // 1. 새로운 주문 그룹 ID 생성
            String generateOrderGroupIdSql = "SELECT COALESCE(MAX(order_group_id), 0) + 1 AS new_order_group_id FROM Orders WHERE memberNum = ?";
            pstmt = conn.prepareStatement(generateOrderGroupIdSql);
            pstmt.setInt(1, memberNum);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                orderGroupId = rs.getInt("new_order_group_id");
            }
            
            // 2. Cart 테이블에서 상품 정보를 조회하여 Orders 테이블에 저장
            String Cartsql = "SELECT * FROM Cart WHERE memberNum = ?";
            pstmt = conn.prepareStatement(Cartsql);
            pstmt.setInt(1, memberNum);
            rs = pstmt.executeQuery();
            
            String sql = "INSERT INTO Orders (memberNum, buyer_name, buyer_addr, buyer_tel, total_price, book_no, quantity, order_group_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, '배송준비중')";
            pstmt = conn.prepareStatement(sql);
            
            while(rs.next()){
                int book_no = rs.getInt("book_no");
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
                
                pstmt.setInt(1, memberNum);
                pstmt.setString(2, buyerName);
                pstmt.setString(3, buyerAddr);
                pstmt.setString(4, buyerTel);
                pstmt.setInt(5, price);
                pstmt.setInt(6, book_no);
                pstmt.setInt(7, quantity);
                pstmt.setInt(8, orderGroupId);
                pstmt.executeUpdate();
            }
            
            // 3. 카트 정보를 삭제
            String deleteCartSql = "DELETE FROM Cart WHERE memberNum = ?";
            pstmt = conn.prepareStatement(deleteCartSql);
            pstmt.setInt(1, memberNum);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("결제 처리 중 오류가 발생했습니다.");
        } finally {
            JDBCUtil.close(pstmt, conn);
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 완료</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="text-center">결제 완료</h1>
        <p class="text-center">결제가 완료되었습니다. 감사합니다!</p>
        <a href="../index.jsp" class="btn btn-primary btn-block">다시 쇼핑하기</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>