<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<s:query var="rs" dataSource="jdbc/MySQLDB">
	SELECT board_name, board_title, board_content FROM test_board 
	WHERE board_num = ${param.board_num}
</s:query>

<s:update dataSource="jdbc/MySQLDB">
	UPDATE test_board 
	SET board_readcount = board_readcount + 1 
	WHERE board_num = ${param.board_num}
</s:update>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 상세내용</h1>
	<table>
		<tr>
			<td>작성자</td>
			<td>${rs.rows[0].board_name}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${rs.rows[0].board_title}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea readonly cols=40 rows=10>${rs.rows[0].board_content}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan=2>
				<a href="board_update.jsp?board_num=${param.board_num}">[수정]</a>
				<a href="board_delete.jsp?board_num=${param.board_num}">[삭제]</a>
				<a href="board_list.jsp">[목록]</a>
			</td>
		</tr>
	</table>
</body>
</html>