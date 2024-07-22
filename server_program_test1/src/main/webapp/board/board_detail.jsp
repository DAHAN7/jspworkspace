<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, vo.TestBoardVO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 상세보기</title>
</head>
<body>
    <h1>게시글 상세보기</h1>

    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int boardNum = Integer.parseInt(request.getParameter("boardNum")); // 게시글 번호

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_jsp", "digital", "1234");

            // 조회수 증가
            String updateReadCountSql = "UPDATE test_board SET board_readcount = board_readcount + 1 WHERE board_num = ?";
            pstmt = conn.prepareStatement(updateReadCountSql);
            pstmt.setInt(1, boardNum);
            pstmt.executeUpdate();

            // 게시글 조회
            String selectSql = "SELECT * FROM test_board WHERE board_num = ?";
            pstmt = conn.prepareStatement(selectSql);
            pstmt.setInt(1, boardNum);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                TestBoardVO board = new TestBoardVO();
                board.setBoard_num(rs.getInt("board_num"));
                board.setBoard_name(rs.getString("board_name"));
                board.setBoard_pass(rs.getString("board_pass"));
                board.setBoard_title(rs.getString("board_title"));
                board.setBoard_content(rs.getString("board_content"));
                board.setBoard_readcount(rs.getInt("board_readcount"));
                board.setBoard_date(rs.getTimestamp("board_date"));

                // 게시글 정보를 JSP에 전달
                request.setAttribute("board", board);
            } else {
                out.println("해당 게시글이 없습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
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
    %>

    <c:if test="${not empty board}">
        <table border="1">
            <tr>
                <th>작성자</th>
                <td>${board.board_name}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${board.board_title}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea readonly cols="40" rows="10">${board.board_content}</textarea>
                </td>
            </tr>
            <tr>
                <th>작성시간</th>
                <td>${board.board_date}</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${board.board_readcount}</td>
            </tr>
            <tr>
                <td colspan="2">
                    <a href="${pageContext.request.contextPath}/board/board_update.jsp?boardNum=${board.board_num}">[수정]</a>
                    <a href="${pageContext.request.contextPath}/board/board_delete.jsp?boardNum=${board.board_num}">[삭제]</a>
                    <a href="${pageContext.request.contextPath}/board/board_list.jsp">[목록]</a>
                </td>
            </tr>
        </table>
    </c:if>
</body>
</html>
