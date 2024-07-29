<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>webapp/index.jsp</title>
</head>
<body>
			    <% 
			    	int memberType = (Integer) session.getAttribute("memberType");
			    	if(memberType != 2){
			    %>
				    <script >
		    			location.href="../member/login.jsp"
				    </script>
				<%
			    	}
				%>
	<h1>team project</h1>
	<h3>jsp index information..</h3>
	<hr />
	<h2><a href="../index.jsp">1. 상품 판매 main form page - [ index.jsp ]</a></h2>
	<h2><a href="insert_form.jsp">2. 상품 등록 form page - [ insert_form.jsp ] - 완료</a></h2>
	<hr />
	<h2><a href="list_update_delete.jsp">3. 상품 등록 후 재고 list form page - [ list_update_delete.jsp ] - 완료 </a></h2>
	<hr />
	<h2><a href="adminBod.jsp">4. 도서 신청 관리 페이지 adminBod - [adminBod.jsp]</a></h2>
	<hr />
	<h2><a href="adminPage.jsp">5. 회원 정보 관리 페이지 adminPage - [adminPage.jsp]</a></h2>
<!-- 	<h2><p>8. 재고 삭제 code page - [ book_delete.jsp ] - 완료</p></h2>s
	<h2><p>9. 등록 id 중복 체크 code page - [ check_book_id.jsp ] - 완료</p></h2>
	<h2><p></p></h2>	
	<h2><p>12. database 연결 작업 및 자원해제 담당 class - [ JDBCUtil.java ] - 완료</p></h2>	 -->
</body>
</html> 