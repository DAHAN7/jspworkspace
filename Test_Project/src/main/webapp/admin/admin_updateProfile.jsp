<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, servlet.*" %>

<%
	//세션에서 사용자 ID 가져오기
	String userId = (String)session.getAttribute("userId");
	Integer userType = (Integer) session.getAttribute("memberType");
	
	// 관리자 권한 체크
	if (userType == null || userType != 2) {
     	response.sendRedirect("../index.jsp"); // 관리자 권한이 없으면 메인 페이지로 리다이렉트
     return;
 	}

	// 사용자로부터 수정된 정보 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	String mId = request.getParameter("mId");
	String email = request.getParameter("email");
	String mPw = request.getParameter("mPw");
	String phone = request.getParameter("phone");
	String birth = request.getParameter("birth");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String addr3 = request.getParameter("addr3");
	String gender = request.getParameter("gender");
	int money = Integer.parseInt(request.getParameter("money"));
	int type = Integer.parseInt(request.getParameter("type"));
	String withdraw = request.getParameter("withdraw");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		conn = DBUtil.getConnection();
		
		// SQL UPDATE 문
		String sql = "UPDATE member SET memberName = ?, memberEmail = ?, memberPassword = ?, memberPhone = ?, " +
                	 "memberBirth = ?, memberAddr1 = ?, memberAddr2 = ?, memberAddr3 = ?, memberGender = ?, " +
                	 "money = ?, memberType = ?, memberWithdraw = ? WHERE memberNum = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
	    pstmt.setString(2, email);
	    pstmt.setString(3, mPw);
	    pstmt.setString(4, phone);
	    pstmt.setString(5, birth);
	    pstmt.setString(6, addr1);
	    pstmt.setString(7, addr2);
	    pstmt.setString(8, addr3);
	    pstmt.setString(9, gender);
	    pstmt.setInt(10, money);
	    pstmt.setInt(11, type);
	    pstmt.setString(12, withdraw);
	    pstmt.setInt(13, num);
		
		int rowUpdate = pstmt.executeUpdate();
		
		if (rowUpdate > 0) {
%>
			<script>
			alert('성공적으로 수정했습니다.');
			window.location.href = 'adminPage.jsp';
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