<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, utils.JDBCUtil" %>
<%
    int memberNum = Integer.parseInt(request.getParameter("memberNum"));
    int book_no = Integer.parseInt(request.getParameter("book_no"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int price = Integer.parseInt(request.getParameter("price"));
    int totalPrice = price * quantity;
    try {
        // 데이터베이스 연결
        conn = JDBCUtil.getConnection();

        // 같은 상품이 이미 장바구니에 있는지 확인
        String checkSql = "SELECT quantity FROM Cart WHERE memberNum = ? AND book_no = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setInt(1, memberNum);
        pstmt.setInt(2, book_no);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // 이미 장바구니에 있는 경우 수량을 업데이트
            int existingQuantity = rs.getInt("quantity");
            int newQuantity = existingQuantity + quantity;
            String updateSql = "UPDATE Cart SET quantity = ?, price = ? WHERE memberNum = ? AND book_no = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, price * newQuantity);
            pstmt.setInt(3, memberNum);
            pstmt.setInt(4, book_no);
            pstmt.executeUpdate();
        } else {
            // 장바구니에 없는 경우 새로 추가
            String insertSql = "INSERT INTO Cart (memberNum, book_no, quantity, price) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setInt(1, memberNum);
            pstmt.setInt(2, book_no);
            pstmt.setInt(3, quantity);
            pstmt.setInt(4, totalPrice);
            pstmt.executeUpdate();
        }

        // 성공 메시지 반환
        response.getWriter().write("success");
    } catch (Exception e) {
        // 예외 처리 및 오류 메시지 반환
        e.printStackTrace();
        response.getWriter().write("error");
    } finally {
        // 자원 해제
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
