<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, vo.TestBoardVO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 수정</title>
</head>
<body>
    <h1>게시물 수정</h1>

    <!-- 메시지 출력 -->
    <c:if test="${not empty message}">
        <p style="color: red;">${message}</p>
    </c:if>

    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int boardNum = Integer.parseInt(request.getParameter("boardNum")); // 게시글 번호

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_jsp", "digital", "1234");

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

    <form action="board_update_submit.jsp" method="post">
        <input type="hidden" name="boardNum" value="${board.board_num}"/>
        <table>
            <tr>
                <td>작성자</td>
                <td><input type="text" name="boardName" value="${board.board_name}" readonly/></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="boardPass" required/></td>
            </tr>
            <tr>
                <td>제목</td>
                <td><input type="text" name="boardTitle" value="${board.board_title}"/></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea name="boardContent" rows="10" cols="40">${board.board_content}</textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="수정완료"/>
                    <a href="${pageContext.request.contextPath}/board/board_detail.jsp?boardNum=${board.board_num}">[취소]</a>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
