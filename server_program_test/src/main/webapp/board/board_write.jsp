<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8, 페이지 인코딩 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 코어 라이브러리 사용, 접두사 'c' --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- HTML5 문자셋 UTF-8 설정 --%>
<title>Insert title here</title>
</head>
<body>

	<h1>글 작성</h1> <%-- 게시글 작성 폼 제목 --%>

	<form action="board_write_submit.jsp" method="post"> <%-- 폼 데이터를 board_write_submit.jsp로 POST 방식 전송 --%>
		<table>
			<tr>
				<td>작성자</td> <%-- 작성자 입력 필드 레이블 --%>
				<td><input type="text" name="board_name"/></td> <%-- 작성자 입력 필드 (text) --%>
			</tr>
			<tr>
				<td>비밀번호</td> <%-- 비밀번호 입력 필드 레이블 --%>
				<td><input type="password" name="board_pass"/></td> <%-- 비밀번호 입력 필드 (password) --%>
			</tr>
			<tr>
				<td>글제목</td> <%-- 글제목 입력 필드 레이블 --%>
				<td><input type="text" name="board_title"/></td> <%-- 글제목 입력 필드 (text) --%>
			</tr>
			<tr>
				<td>글 내용</td> <%-- 글 내용 입력 필드 레이블 --%>
				<td>
					<textarea cols=50 rows=10 name="board_content"></textarea> <%-- 글 내용 입력 필드 (textarea) --%>
				</td>
			</tr>
			<tr>
				<td colspan=2> <%-- 버튼 셀 병합 --%>
					<input type="submit" value="작성완료"/> <%-- 작성완료 버튼 (submit) --%>
					<input type="reset" value="새로작성"/> <%-- 새로작성 버튼 (reset) --%>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>