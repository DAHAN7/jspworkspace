<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ page import="java.io.*, java.util.*" %>

<% 
	// name == profileImage file upload
	String path = "C:\\Users\\admin\\Desktop\\workspace\\jsp_workspace\\semi\\group_project\\src\\main\\webapp\\img";
	File file = new File(path);
	if(!file.exists()){
		file.mkdirs();
	}
%>

<jsp:useBean id="insertBook" class="vo.BooksVO" />
<jsp:setProperty property="*" name="insertBook" />

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
				insertBook.setBook_fileName(fileName);
			}
		}
	}
%>

<s:update var="result" dataSource="jdbc/MySQLDB">

	INSERT INTO books
	(book_id,title,author,publisher,book_memo,new_old_ebook,price,stock,category_overseas,category_age,category_all,book_fileName)
	VALUES (?,?,?,?,?,?,?,?,?,?,?,?);		
	
	<s:param>${insertBook.book_id}</s:param>
	<s:param>${insertBook.title}</s:param>
	<s:param>${insertBook.author}</s:param>
	<s:param>${insertBook.publisher}</s:param>
	<s:param>${insertBook.book_memo}</s:param>
	<s:param>${insertBook.new_old_ebook}</s:param>
	<s:param>${insertBook.price}</s:param>
	<s:param>${insertBook.stock}</s:param>
	<s:param>${insertBook.category_overseas}</s:param>
	<s:param>${insertBook.category_age}</s:param>
	<s:param>${insertBook.category_all}</s:param>
	<s:param>${insertBook.book_fileName}</s:param>
	
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
















