<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8, 페이지 인코딩 UTF-8 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 코어 라이브러리 사용, 접두사 'c' --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- HTML5 문자셋 UTF-8 설정 --%>
<title>Insert title here</title>
</head>
<body>

	<h1>게시물 수정</h1> <%-- 게시물 수정 폼 제목 --%>

	<form action="board_update_submit.jsp" method="post"> <%-- 폼 데이터를 board_update_submit.jsp로 POST 방식 전송 --%>
		<table>
			<tr>
				<td>작성자</td> <%-- 작성자 입력 필드 레이블 (수정 불가) --%>
				<td><input type="text" readonly /></td> <%-- 작성자 입력 필드 (readonly 속성으로 수정 불가) --%>
			</tr>
			<tr>
				<td>비밀번호</td> <%-- 비밀번호 입력 필드 레이블 (필수 입력) --%>
				<td><input type="password" required /></td> <%-- 비밀번호 입력 필드 (required 속성으로 필수 입력) --%>
			</tr>
			<tr>
				<td>제목</td> <%-- 제목 입력 필드 레이블 --%>
				<td><input type="text" /></td> <%-- 제목 입력 필드 --%>
			</tr>
			<tr>
				<td>내용</td> <%-- 내용 입력 필드 레이블 --%>
				<td><textarea rows=10 cols=40></textarea></td> <%-- 내용 입력 필드 (textarea) --%>
			</tr>
			<tr>
				<td colspan=2> <%-- 버튼 셀 병합 --%>
					<input type="submit" value="수정완료"/> <%-- 수정완료 버튼 (submit) --%>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
