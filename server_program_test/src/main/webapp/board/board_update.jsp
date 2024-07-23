<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL Core 태그 라이브러리 사용 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %> <%-- JSTL SQL 태그 라이브러리 사용 --%>

<%-- 게시글 데이터 조회 --%>
<s:query var="rs" dataSource="jdbc/MySQLDB"> <%-- SQL 쿼리 실행, 결과를 rs 변수에 저장 (ResultSet 객체) --%>
	SELECT * FROM test_board WHERE board_num = ${param.board_num} <%-- 수정할 게시글 번호로 데이터 조회 --%>
</s:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자셋 UTF-8 설정 --%>
<title>Insert title here</title> <%-- 페이지 제목 (나중에 적절한 제목으로 변경) --%>
</head>
<body>
	<h1>게시물 수정</h1> <%-- 페이지 주요 제목 --%>

	<form action="board_update_submit.jsp" method="post"> <%-- 수정 처리 JSP 페이지로 POST 방식 전송 --%>
		<input type="hidden" name="board_num" value="${param.board_num}"/> <%-- 수정할 게시물 번호를 숨겨서 전달 --%>
		<table>
			<tr> <%-- 작성자 입력 영역 --%>
				<td>작성자</td>
				<td><input type="text" name="board_name" value="${rs.rows[0].board_name}" /></td> <%-- 기존 작성자 이름 표시 --%>
			</tr>
			<tr> <%-- 비밀번호 입력 영역 --%>
				<td>비밀번호</td>
				<td><input type="password" name="board_pass" required/></td> <%-- 비밀번호 입력 필드 (필수) --%>
			</tr>
			<tr> <%-- 제목 입력 영역 --%>
				<td>제목</td>
				<td><input type="text" name="board_title" value="${rs.rows[0].board_title}"/></td> <%-- 기존 제목 표시 --%>
			</tr>
			<tr> <%-- 내용 입력 영역 --%>
				<td>내용</td>
				<td><textarea rows=10 cols=40 name="board_content">${rs.rows[0].board_content}</textarea></td> <%-- 기존 내용 표시 --%>
			</tr>
			<tr> <%-- 수정 완료 버튼 --%>
				<td colspan=2><input type="submit" value="수정완료"/></td>
			</tr>
		</table>
	</form>
</body>
</html>
