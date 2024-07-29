<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, servlet.*, java.util.*" %>

<%
        String mId = request.getParameter("mId");
        String email = request.getParameter("email");
        String newPw = request.getParameter("newPw");
        String newPwChk = request.getParameter("newPwChk");
        
        // 비밀번호 확인 및 변경 처리
        MemberDAO memberDAO = new MemberDAO();
        
        if(newPw.equals(newPwChk)) {
        		// 비밀번호 변경
        		memberDAO.updateReset(newPwChk, mId, email);
        		// 비밀번호 변경 완료 후 메인 페이지로 리다이렉트
        		response.sendRedirect("index.jsp");
        } else {
        	// 새 비밀번호와 확인 비밀번호 불일치
%>
        	<script>
				alert('비밀번호를 다시 확인해 주세요.')
				history.back();
        	</script>
<%
        }

%>