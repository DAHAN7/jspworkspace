<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8, 페이지 인코딩 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 코어 라이브러리 사용, 접두사 'c' --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 라이브러리 사용, 접두사 's' --%>

<%-- 게시글 정보 조회 --%>
<s:query var="rs" dataSource="jdbc/MySQLDB">
	SELECT board_name, board_title, board_content FROM test_board 
	WHERE board_num = ${param.board_num} <%-- board_num 파라미터로 특정 게시글 조회 --%>
</s:query>

<%-- 조회수 증가 --%>
<s:update dataSource="jdbc/MySQLDB">
	UPDATE test_board 
	SET board_readcount = board_readcount + 1 <%-- 조회수 1 증가 --%>
	WHERE board_num = ${param.board_num} <%-- board_num 파라미터로 특정 게시글 업데이트 --%>
</s:update>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>게시물 상세내용</h1> <%-- 게시물 상세 페이지 제목 --%>

	<table> <%-- 게시물 상세 정보 테이블 --%>
		<tr>
			<td>작성자</td>
			<td>${rs.rows[0].board_name}</td> <%-- 작성자 이름 출력 --%>
		</tr>
		<tr>
			<td>제목</td>
			<td>${rs.rows[0].board_title}</td> <%-- 제목 출력 --%>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea readonly cols=40 rows=10>${rs.rows[0].board_content}</textarea> <%-- 내용 출력 (readonly 속성으로 수정 불가) --%>
			</td>
		</tr>
		<tr>
			<td colspan=2> <%-- 버튼 셀 병합 --%>
				<a href="board_update.jsp?board_num=${param.board_num}">[수정]</a> <%-- 수정 페이지 링크 (board_num 파라미터 전달) --%>
				<a href="board_delete.jsp?board_num=${param.board_num}">[삭제]</a> <%-- 삭제 페이지 링크 (board_num 파라미터 전달) --%>
				<a href="board_list.jsp">[목록]</a> <%-- 게시글 목록 페이지 링크 --%>
			</td>
		</tr>
	</table>

</body>
</html>
