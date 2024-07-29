<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ page import="java.io.*, java.util.*" %>

<% 
	// name == profileImage file upload
	String path = "D:\\JsBackUp\\workspace\\public\\jsp_workspace\\yjs\\src\\main\\webapp\\img";
	File file = new File(path);
	if(!file.exists()){
		file.mkdirs();
	}
%>

<jsp:useBean id="updateBook" class="vo.BooksVO" />
<jsp:setProperty property="*" name="updateBook" />

<% 
	Collection<Part> parts = request.getParts();
	if(parts != null){
		for(Part p : parts){
			if(p.getContentType() != null && p.getName().equals("book_Image")){
			
				// 원본 파일 이름
				String fileName = p.getSubmittedFileName();
				UUID uid = UUID.randomUUID();
				fileName = uid.toString().replace("-","")+"_"+fileName;
				String uploadPath = path + File.separator + fileName;
				System.out.println("uploadPath : " + uploadPath);
				// 업로드된 임시파일을 uploadPath copy
				p.write(uploadPath);
				p.delete();
				updateBook.setBook_fileName(fileName);
			}
		}
	}
%>
<s:update var="result" dataSource="jdbc/MySQLDB">

	UPDATE books SET 
	title=?, author=?, publisher=?, book_memo=?, new_old_ebook=?,
	price=?, stock=?, category_overseas=?, category_age=?, category_all=?, book_fileName=?
	WHERE book_no = ? ;
	
	<s:param>${updateBook.title}</s:param>
	<s:param>${updateBook.author}</s:param>
	<s:param>${updateBook.publisher}</s:param>
	<s:param>${updateBook.book_memo}</s:param>
	<s:param>${updateBook.new_old_ebook}</s:param>
	<s:param>${updateBook.price}</s:param>
	<s:param>${updateBook.stock}</s:param>
	<s:param>${updateBook.category_overseas}</s:param>
	<s:param>${updateBook.category_age}</s:param>
	<s:param>${updateBook.category_all}</s:param>
	<s:param>${updateBook.book_fileName}</s:param>
	<s:param>${updateBook.book_no}</s:param>
	
</s:update>

<c:choose>
	<c:when test="${result == 1}">
		<script>
			alert('재고등록 성공');
			location.href='insert_form.jsp';
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert('재고등록 실패');
			history.go(-1);
		</script>
	</c:otherwise>
</c:choose>
















