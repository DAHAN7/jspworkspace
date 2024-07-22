<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 수정 처리</title>
</head>
<body>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        String message = "";
        int boardNum = Integer.parseInt(request.getParameter("boardNum"));
        String boardPass = request.getParameter("boardPass");
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_jsp", "digital", "1234");

            // 게시글 비밀번호 확인
            String checkPassSql = "SELECT board_pass FROM test_board WHERE board_num = ?";
            pstmt = conn.prepareStatement(checkPassSql);
            pstmt.setInt(1, boardNum);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("board_pass");

                if (dbPass.equals(boardPass)) {
                    // 비밀번호가 맞으면 게시글 수정
                    String updateSql = "UPDATE test_board SET board_title = ?, board_content = ? WHERE board_num = ?";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setString(1, boardTitle);
                    pstmt.setString(2, boardContent);
                    pstmt.setInt(3, boardNum);
                    int result = pstmt.executeUpdate();

                    if (result > 0) {
                        response.sendRedirect(request.getContextPath() + "/board/board_detail.jsp?boardNum=" + boardNum);
                    } else {
                        message = "게시물 수정에 실패하였습니다. 다시 시도해 주세요.";
                    }
                } else {
                    message = "비밀번호가 일치하지 않습니다.";
                }
            } else {
                message = "해당 게시글이 존재하지 않습니다.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "오류가 발생했습니다. 관리자에게 문의해 주세요.";
        } finally {
            // 자원 해제
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // 수정 실패 시 수정 페이지로 리다이렉트
        if (!message.isEmpty()) {
            request.setAttribute("message", message);
            request.getRequestDispatcher("/board/board_update.jsp?boardNum=" + boardNum).forward(request, response);
        }
    %>
</body>
</html>
