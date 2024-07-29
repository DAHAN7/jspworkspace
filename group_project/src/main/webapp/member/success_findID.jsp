<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, servlet.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String code = request.getParameter("code");
    String emailCode = (String) session.getAttribute("emailCode");  // 세션에 저장된 발송된 코드
	
    String memberId = "";
    String memberName = "";
    
    if (code.equals(emailCode)) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT memberId FROM member WHERE memberName = ? AND memberEmail = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                memberId = rs.getString("memberId");
            } else {
%>
                <script>
                	alert('아이디를 찾을 수 없습니다.');
                	history.back();
                </script>
<%
            }
        } catch (Exception e) {
            	e.printStackTrace();
        } finally {
            DBUtil.close(rs, pstmt, conn);
        }
    } else {
%>
		<script>
			alert('인증코드가 일치하지 않습니다.');
			history.back();
		</script>
<%
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디찾기 - BASKINROBBINS 31.2</title>
    <link href="../css/find.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <div>
        <p>고객님의 정보와 일치하는 ID입니다.</p>
        <p><%= memberId %></p>
        <a href="login.jsp"><button>로그인</button></a>
    </div>
</body>
</html>