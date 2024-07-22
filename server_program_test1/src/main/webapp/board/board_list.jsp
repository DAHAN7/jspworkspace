<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, java.util.List, java.util.ArrayList, vo.TestBoardVO" %>

<%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int pageNum = request.getParameter("pageNum") != null ? Integer.parseInt(request.getParameter("pageNum")) : 1;
        int perPageNum = 10; // 한 페이지에 표시할 게시글 수
        int startRow = (pageNum - 1) * perPageNum;

        int totalCount = 0;
        int startPage;
        int endPage;
        int displayPageNum = 5; // 한번에 보여줄 페이지 블럭 수
        int maxPage;
        boolean prev;
        boolean next;

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/digital_jsp", "digital", "1234");

            // 총 게시글 수 조회
            String countSql = "SELECT COUNT(*) FROM test_board";
            pstmt = conn.prepareStatement(countSql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }

            // 페이징 처리 계산
            maxPage = (int) Math.ceil(totalCount / (double) perPageNum);
            startPage = ((pageNum - 1) / displayPageNum) * displayPageNum + 1;
            endPage = startPage + displayPageNum - 1;
            if (endPage > maxPage) {
                endPage = maxPage;
            }
            prev = (startPage > 1);
            next = (endPage < maxPage);

            // 게시글 목록 조회
            String sql = "SELECT * FROM test_board ORDER BY board_num DESC LIMIT ?, ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, perPageNum);
            rs = pstmt.executeQuery();

            List<TestBoardVO> boardList = new ArrayList<>();
            while (rs.next()) {
                TestBoardVO board = new TestBoardVO();
                board.setBoard_num(rs.getInt("board_num"));
                board.setBoard_name(rs.getString("board_name"));
                board.setBoard_pass(rs.getString("board_pass"));
                board.setBoard_title(rs.getString("board_title"));
                board.setBoard_content(rs.getString("board_content"));
                board.setBoard_readcount(rs.getInt("board_readcount"));
                board.setBoard_date(rs.getTimestamp("board_date")); // Timestamp로 수정
                boardList.add(board);
            }

            // 페이지 정보와 게시글 목록을 JSP 페이지로 전달
            request.setAttribute("boardList", boardList);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
            request.setAttribute("displayPageNum", displayPageNum);
            request.setAttribute("maxPage", maxPage);
            request.setAttribute("currentPage", pageNum);
            request.setAttribute("prev", prev);
            request.setAttribute("next", next);

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

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
</head>
<body>
    <h1>게시글 목록</h1>
    <a href="${pageContext.request.contextPath}/board/board_write.jsp">게시글 작성하러 가기</a>

    <table border="1">
        <tr>
            <th>글번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성시간</th>
            <th>조회수</th>
        </tr>

        <!-- 게시글 목록을 반복하여 출력 -->
        <c:forEach items="${boardList}" var="board">
            <tr>
                  <td>${board.board_num}</td>
                <td><a href="${pageContext.request.contextPath}/board/board_detail.jsp?boardNum=${board.board_num}">${board.board_title}</a></td>
                <td>${board.board_name}</td>
                <td>${board.board_date}</td>
                <td>${board.board_readcount}</td>
            </tr>
        </c:forEach>

        <!-- 게시글이 없는 경우 메시지 출력 -->
        <c:if test="${empty boardList}">
            <tr>
                <td colspan="5">등록된 정보가 없습니다.</td>
            </tr>
        </c:if>
    </table>

    <div>
        <!-- 페이지 이동 번호 출력 -->
        <c:choose>
            <c:when test="${prev}">
                <a href="${pageContext.request.contextPath}/board/board_list.jsp?pageNum=${startPage - 1}">[이전]</a>
            </c:when>
            <c:otherwise>
                [이전]
            </c:otherwise>
        </c:choose>

        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${i == currentPage}">
                    [${i}]
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/board/board_list.jsp?pageNum=${i}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:choose>
            <c:when test="${next}">
                <a href="${pageContext.request.contextPath}/board/board_list.jsp?pageNum=${endPage + 1}">[다음]</a>
            </c:when>
            <c:otherwise>
                [다음]
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>
