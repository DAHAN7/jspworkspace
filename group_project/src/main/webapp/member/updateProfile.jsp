<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, servlet.DBUtil" %>

<%
	// 세션에서 사용자 ID 가져오기
	String userId = (String)session.getAttribute("userId");
	
	// 사용자로부터 수정된 정보 가져오기
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String addr3 = request.getParameter("addr3");
	int type = Integer.parseInt(request.getParameter("type"));
	
	// try 안에 한꺼번에 집어서 넣으니까 finally에서 conn, pstmt 오류 발생함
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		// DB 연결
		conn = DBUtil.getConnection();
		
		// SQL UPDATE 문
		String sql = "UPDATE member SET memberName = ?, memberEmail = ?, memberPhone = ?, memberAddr1 = ?, memberAddr2 = ?, memberAddr3 = ?, memberType = ? WHERE memberId = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		pstmt.setString(3, phone);
		pstmt.setString(4, addr1);
		pstmt.setString(5, addr2);
		pstmt.setString(6, addr3);
		pstmt.setInt(7, type);			// type을 숫자(0, 1, 2)로 설정해야 할 수 있습니다.  [input = radio]임
		pstmt.setString(8, userId);
		
		// 쿼리 실행
		int rowUpdate = pstmt.executeUpdate();
		
		if (rowUpdate > 0) {
%>
			<script>
				alert('성공적으로 수정했습니다.');
				window.location.href = '../index.jsp';
			</script>
<%
		} else {
			out.println("<script>alert('정보 수정에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		DBUtil.close(pstmt, conn);
	}
%>