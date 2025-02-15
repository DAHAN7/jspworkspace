<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- JSP 페이지 설정 (언어, 콘텐츠 타입, 문자 인코딩) --%>
<!-- guest_book_delete.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 메세지 삭제 요청 처리</title>
</head>
<body>
	<%@ page import="java.sql.*, utils.JDBCUtil" %><%-- JDBC 및 유틸리티 클래스 import --%>
	<%
	// 1. 삭제할 메시지 번호와 비밀번호 파라미터 받기
		String paramNum = request.getParameter("num");
		String password = request.getParameter("password");
		
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		
		// 실행 결과를 저장할 변수 선언
		String msg = "";
		
		try{
			int num = Integer.parseInt(paramNum);			
			String sql = "DELETE FROM guestBook WHERE num = ? AND password = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, password);
			
			int result = pstmt.executeUpdate();
			
			msg = (result != 1) ? "삭제 실패" : "삭제 성공";
			
		} catch(Exception e){
			msg = "삭제 실패 : " + e.getMessage();
		} finally{
			JDBCUtil.close(pstmt, conn);
		}
	%>
	
	<!-- 삭제 처리 확인 -->
	<h3><%=msg%></h3>
	<a href="guest_book.jsp">방명록 목록 보기</a>
</body>
</html>










