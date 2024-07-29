<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.JDBCUtil" %>
<% 
	//전달된 파라미터 값
	String title = request.getParameter("title");
	String author = request.getParameter("author");
	String publisher = request.getParameter("publisher");
	String book_memo = request.getParameter("book_memo");
	String new_old_ebook = request.getParameter("new_old_ebook");
	String price = request.getParameter("price");
	String stock = request.getParameter("stock");
	String category_overseas = request.getParameter("category_overseas");
	String category_age = request.getParameter("category_age");
	String category_all = request.getParameter("category_all");	
	String book_fileName = request.getParameter("book_fileName");
	String param_book_no = request.getParameter("book_no");
	// String >>> int 변환 
	int price_int = Integer.parseInt(price);
	int stock_int = Integer.parseInt(stock);
	int book_no_int = Integer.parseInt(param_book_no);
	// 전달된 파라미터 일치확인위해 전달된 데이터베이스의 정보를 가져온다.
	Connection conn = JDBCUtil.getConnection();
	// 연결된 데이터베이스에 질의 작업을 수행하고 결과를 반환하는 객체
	PreparedStatement pstmt = null;
	
	try{
		// 쿼리 실행 시 쿼리 실행에 필요한 데이터를 삽입
		String sql = "UPDATE books SET title = ?, author = ?, publisher = ?, book_memo = ?, new_old_ebook = ?, price = ?, stock = ?, category_overseas = ?, category_age = ?, category_all = ?, book_fileName = ? WHERE book_no = ? ";   
		// 쿼리문 등록시켜주고 pstmt로 가지고와서..
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, author);
		pstmt.setString(3, publisher);
		pstmt.setString(4, book_memo);
		pstmt.setString(5, new_old_ebook);
		pstmt.setInt(6, price_int);
		pstmt.setInt(7, stock_int);
		pstmt.setString(8, category_overseas);
		pstmt.setString(9, category_age);
		pstmt.setString(10, category_all);		
		pstmt.setString(11, book_fileName);
		pstmt.setInt(12, book_no_int);
		int rowCount = pstmt.executeUpdate();
%>		

<script>
alert("<%=rowCount %>행 수정 완료.");
location.href = ("book_update_form.jsp?book_no=<%=book_no_int %>");
</script>
		
<%		
	}catch(SQLException e){
		out.println("DB 연결 정보 오류 <br/>");
	}finally{
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
%>	










