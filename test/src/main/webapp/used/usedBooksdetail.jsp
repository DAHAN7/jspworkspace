<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.util.*, jakarta.servlet.http.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고서적 상세보기</title>
<style>
.book-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	padding: 20px;
	box-sizing: border-box;
}

.book-info {
	width: 100%;
	max-width: 300px;
	border: 1px solid #ccc;
	padding: 15px;
	border-radius: 5px;
	box-sizing: border-box;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.book-info img {
	width: 100%;
	height: auto;
	border-radius: 5px 5px 0 0;
}

.book-title {
	font-size: 1.2em;
	margin: 10px 0;
}

.book-details {
	font-size: 0.9em;
	color: #666;
	margin-bottom: 10px;
}

.buttons {
	display: flex;
	justify-content: space-between;
}

.buttons button {
	padding: 8px 12px;
	border: none;
	border-radius: 3px;
	cursor: pointer;
	font-size: 0.9em;
	transition: background-color 0.3s ease;
}

.buy-now {
	background-color: #4CAF50;
	color: white;
}

.add-to-list {
	background-color: #008CBA;
	color: white;
}

.buy-now:hover, .add-to-list:hover {
	opacity: 0.8;
}

@media ( min-width : 768px) {
	.book-info {
		width: calc(50% - 10px);
	}
}

@media ( min-width : 1024px) {
	.book-info {
		width: calc(33.33% - 13.33px);
	}
}
</style>
</head>
<body>
	<div class="book-list">
		<%-- 
        <sql:query var="usedBooks" dataSource="jdbc/MySQLDB">
            SELECT ub.used_book_id, ub.price, ub.status, ub.description, 
                   b.title, b.author, b.publisher, b.image 
            FROM Used_Books ub
            JOIN Books b ON ub.book_id = b.book_id
        </sql:query>
 --%>
		<!-- 이미지 없이 테스트 20240722 7교시-->
		<sql:query var="usedBooks" dataSource="jdbc/baskin">
            SELECT ub.used_book_id, ub.price, ub.status, ub.description, 
                   b.title, b.author, b.publisher 
            FROM Used_Books ub
            JOIN Books b ON ub.book_id = b.book_id
        </sql:query>

		<c:forEach var="book" items="${usedBooks.rows}">
			<!-- 이미지 없이 테스트 20240722 7교시-->
			<%-- <c:set var="bookImage" value="${book.image}" /> --%>
			<c:set var="bookImage" value="${book.image}" />
			<c:if test="${empty bookImage}">
				<c:set var="bookImage"
					value="${pageContext.request.contextPath}/images/default_image.jpg" />
			</c:if>

			<div class="book-info">
				<img src="${bookImage}" alt="${book.title}">
				<h2 class="book-title">${book.title}</h2>
				<p class="book-details">${book.author}저 | ${book.publisher}</p>
				<p class="book-details">판매가: ${book.price}원 (상태: ${book.status})</p>
				<p class="book-details">${book.description}</p>
				<div class="buttons">
					<button class="buy-now" data-used-book-id="${book.used_book_id}">바로구매</button>
					<button class="add-to-list"
						data-used-book-id="${book.used_book_id}">리스트에 넣기</button>
				</div>
			</div>
		</c:forEach>
	</div>
 <form action="${pageContext.request.contextPath}/usedBooksdetail.jsp" method="post" enctype="multipart/form-data">
        <input type="file" name="file" />
        <input type="submit" value="업로드" />
    </form>

	<%
	  if (request.getContentType() != null && request.getContentType().toLowerCase().startsWith("multipart/")) {
          Collection<Part> parts = request.getParts();
          String path = application.getRealPath("/") + "uploads";

          // 업로드 디렉토리가 존재하지 않으면 생성
          File uploadDir = new File(path);
          if (!uploadDir.exists()) {
              uploadDir.mkdir();
          }

          // multipart 로 전달된 데이터가 존재할 경우
          if (parts != null) {
              for (Part part : parts) {
                  if (part.getContentType() != null) {
                      // 업로드된 파일의 실제 이름
                      String fileName = part.getSubmittedFileName();
                      UUID uid = UUID.randomUUID();
                      fileName = uid.toString().replace("-", "") + "_" + fileName;
                      String uploadPath = path + File.separator + fileName;

                      // 파일 저장
                      part.write(uploadPath);
                      // 임시 디렉토리 파일 삭제
                      part.delete();

                      String original = part.getSubmittedFileName();
                      out.println("<a href='uploads/" + fileName + "' download='" + original + "'>" + original + "</a> <br/>");
                  }
              }
          }
      }
  %>
	<script>
	 document.addEventListener('DOMContentLoaded', function() {
         document.querySelector('.book-list').addEventListener('click', function(e) {
             if (e.target.classList.contains('buy-now')) {
                 var usedBookId = e.target.getAttribute('data-used-book-id');
                 var xhr = new XMLHttpRequest();
                 xhr.open('POST', '${pageContext.request.contextPath}/buyNowServlet', true);
                 xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                 xhr.onload = function() {
                     if (xhr.status === 200) {
                         alert(xhr.responseText);
                     } else {
                         alert('구매 처리 중 오류가 발생했습니다.');
                     }
                 };
                 xhr.send('usedBookId=' + usedBookId);
             }
             if (e.target.classList.contains('add-to-list')) {
                 var usedBookId = e.target.getAttribute('data-used-book-id');
                 var xhr = new XMLHttpRequest();
                 xhr.open('POST', '${pageContext.request.contextPath}/addToListServlet', true);
                 xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                 xhr.onload = function() {
                     if (xhr.status === 200) {
                         alert(xhr.responseText);
                     } else {
                         alert('리스트 추가 중 오류가 발생했습니다.');
                     }
                 };
                 xhr.send('usedBookId=' + usedBookId);
             }
         });
     });
 </script>
</body>
</html>