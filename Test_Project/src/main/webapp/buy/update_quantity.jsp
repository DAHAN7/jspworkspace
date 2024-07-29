<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.JDBCUtil" %>
<%
    int book_id = Integer.parseInt(request.getParameter("book_id"));
    int memberNum = Integer.parseInt(request.getParameter("memberNum"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    String result = "";

    try {
        conn = JDBCUtil.getConnection();
        String sql = "UPDATE Cart SET quantity = ? WHERE book_id = ? AND memberNum = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, quantity);
        pstmt.setInt(2, book_id);
        pstmt.setInt(3, memberNum);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            result = "success";
        } else {
            result = "failure";
        }
    } catch (Exception e) {
        e.printStackTrace();
        result = "error";
    } finally {
        JDBCUtil.close(pstmt, conn);
    }

    out.print(result);
%>
