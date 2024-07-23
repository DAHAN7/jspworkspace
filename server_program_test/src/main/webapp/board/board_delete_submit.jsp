<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL Core 태그 라이브러리 사용 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 태그 라이브러리 사용 --%>

<%-- 게시글 삭제 요청 처리 --%>
<s:update var="result" dataSource="jdbc/MySQLDB"> <%-- SQL UPDATE 쿼리 실행, 결과를 result 변수에 저장 --%>
    DELETE FROM test_board  <%-- test_board 테이블에서 삭제 --%>
    WHERE board_num = ${param.board_num} AND board_pass = ? <%-- 게시물 번호와 비밀번호 일치 조건 --%>
    <s:param>${param.board_pass}</s:param> <%-- 비밀번호 파라미터 설정 --%>
</s:update>

<%-- 게시글 삭제 요청 결과 처리 --%>
<c:choose> <%-- 조건에 따른 분기 처리 --%>
    <c:when test="${result > 0}"> <%-- 삭제 성공 시 (result 값이 0보다 크면) --%>
        <script>
            alert('삭제 완료'); <%-- 알림 메시지 표시 --%>
            location.href='board_list.jsp'; <%-- 게시판 목록 페이지로 이동 --%>
        </script>
    </c:when>
    <c:otherwise> <%-- 삭제 실패 시 --%>
        <script>
            alert('삭제 실패'); <%-- 알림 메시지 표시 --%>
            history.back(); <%-- 이전 페이지로 이동 --%>
        </script>
    </c:otherwise>
</c:choose>
