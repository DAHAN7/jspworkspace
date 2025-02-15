<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
	<h1>글 작성</h1>
	<form
		action="${pageContext.request.contextPath}/board/board_write_submit.jsp"
		method="post">
		<table>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer" required /></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password" required /></td>
			</tr>
			<tr>
				<td>글제목</td>
				<td><input type="text" name="title" required /></td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td><textarea name="content" cols="50" rows="10" required></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="작성완료" /> <input
					type="reset" value="새로작성" /></td>
			</tr>
		</table>
	</form>
</body>
</html>