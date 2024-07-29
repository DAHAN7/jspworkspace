<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="servlet.*" %>

<%
    response.setContentType("application/json; charset=UTF-8");

    String mId = request.getParameter("mId");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DBUtil.getConnection();

        String sql = "SELECT COUNT(*) FROM member WHERE memberId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, mId);
        rs = pstmt.executeQuery();

        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }

        // JSON 형식으로 응답 생성
        String jsonResponse;
        if (count > 0) {
            jsonResponse = "{\"status\": \"EXISTS\", \"message\": \"사용 중인 아이디입니다.\"}";
        } else {
            jsonResponse = "{\"status\": \"OK\", \"message\": \"사용 가능한 아이디입니다.\"}";
        }

        out.print(jsonResponse);
    } catch (Exception e) {
        e.printStackTrace();
        String errorResponse = "{\"status\": \"ERROR\", \"message\": \"서버 오류 발생.\"}";
        out.print(errorResponse);
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>