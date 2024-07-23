<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL Core 태그 라이브러리 사용 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자셋 UTF-8 설정 --%>
<title>Insert title here</title> <%-- 페이지 제목 (나중에 적절한 제목으로 변경) --%>
</head>
<body>
    <h1>게시물 삭제</h1> <%-- 페이지 주요 제목 --%>

    <form action="board_delete_submit.jsp" method="post"> <%-- 삭제 처리 JSP 페이지로 POST 방식 전송 --%>
        <input type="hidden" name="board_num" value="${param.board_num}"/> <%-- 삭제할 게시물 번호를 숨겨서 전달 --%>
        비밀번호 : <input type="password" name="board_pass"/> <%-- 게시물 비밀번호 입력 필드 --%>
        <input type="submit" value="삭제"/> <%-- 삭제 버튼 --%>
    </form>

    <a href="#">목록</a> <%-- 게시물 목록 페이지 링크 (나중에 실제 링크로 변경) --%>
</body>
</html>
