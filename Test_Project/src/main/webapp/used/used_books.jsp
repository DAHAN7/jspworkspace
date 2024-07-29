<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*, used.Book"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="category"
	value="인문,역사,예술,종교,사회,과학,경제,IT,취미,요리,여행,잡지,만화,육아,건강,스포츠,유아교재,초등참고서,중등참고서,고등참고서,외국어,자격증" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>중고 도서 판매 - 배스킨라빈스31.2</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/used/style.css">
</head>
<body>
	<header class="header">
		<h1>중고샵</h1>
		<p>해외 직배송 도서 모음!</p>
	</header>

	<main>
		<div class="container">
			<!-- 네비게이션 및 도서 업로드 폼 -->
			<nav class="category">
				<h2>카테고리</h2>
				<ul>
					<li class="category-item">
						<button class="category-title" data-category="foreign-books">
							중고 외국도서 <i class="arrow down"></i>
						</button>
						<ul id="foreign-books" class="subcategory-list">
							<c:forTokens var="category_names" items="${category}" delims=",">
								<li class="subcategory-item"><a
									href="${pageContext.request.contextPath}/used/usedbooklist/UsedBookList.jsp?category_overseas=외국도서&category_all=${category_names}">${category_names}</a>
								</li>
							</c:forTokens>
						</ul>
					</li>
					<li class="category-item">
						<button class="category-title" data-category="domestic-books">
							중고 국내도서 <i class="arrow down"></i>
						</button>
						<ul id="domestic-books" class="subcategory-list">
							<c:forTokens var="category_names" items="${category}" delims=",">
								<li class="subcategory-item"><a
									href="${pageContext.request.contextPath}/used/usedbooklist/UsedBookList.jsp?category_overseas=국내도서&category_all=${category_names}">${category_names}</a>
								</li>
							</c:forTokens>
						</ul>
					</li>
				</ul>
			</nav>

			<section class="used-book-upload">
				<h2>중고 도서 판매</h2>
				<p>등록하실 도서의 정보를 입력해주세요.</p>
				<form id="registerBookForm"
					action="${pageContext.request.contextPath}/used/registerBook.jsp"
					method="POST" enctype="multipart/form-data">
					<div class="form-row">
						<label for="book-title">제품등록 아이디:</label> <input type="text"
							id="book-title" name="book_id" required>
					</div>
					<div class="form-row">
						<label for="book-title">도서명:</label> <input type="text"
							id="book-title" name="title" required>
					</div>
					<div class="form-row">
						<label for="book-author">저자:</label> <input type="text"
							id="book-author" name="author" required>
					</div>
					<div class="form-row">
						<label for="book-publisher">출판사:</label> <input type="text"
							id="book-publisher" name="publisher" required>
					</div>
					<div class="form-row">
						<label for="book-memo">한줄 소개:</label>
						<textarea id="book-memo" name="book_memo"></textarea>
					</div>
					<div class="form-row">
						<label for="book-status">도서 상태:</label> <input type="text"
							id="book-status" name="new_old_ebook" value="중고" readonly />
					</div>
					<div class="form-row">
						<label for="book-price">판매 가격:</label> <input type="number"
							id="book-price" name="price" min="1000" required> 원
					</div>
					<div class="form-row">
						<label for="book-stock">입고 수량:</label> <input type="number"
							id="book-stock" name="stock" min="1" required>
					</div>
					<div class="form-row">
						<label for="book-category-overseas">국내/외 구분:</label> <select
							id="book-category-overseas" name="category_overseas" required>
							<option value="국내도서">국내</option>
							<option value="해외도서">해외</option>
						</select>
					</div>
					<div class="form-row">
						<label for="book-category-age">연령대 구분:</label> 
						<select id="book-category-overseas" name="category_overseas" required>
							<option value="10대">10대</option>
							<option value="20대">20대</option>
							<option value="30대">30대</option>
							<option value="40대">40대</option>
							<option value="50대+">50대+</option>
						</select>

					</div>
					<div class="form-row">
						<label for="book-category-all">대분류:</label> 
						<%-- <input type="text" id="book-category-all" name="category_all" value="${param.category_all}" readonly> --%>
						<select id="book-category-all" name="category_all">
							<c:forTokens var="category_names" items="${category}" delims=",">
								<option value="${category_names}">${category_names}</option>
							</c:forTokens>
						</select>
					</div>
					<div class="form-row">
						<label for="book-images">사진 업로드:</label> <input type="file"
							id="book-images" name="book_fileName" accept="image/*">
					</div>
					<input type="hidden" id="seller-id" name="seller_id"
						value="${sessionScope.memberNum}">
					<button type="submit" class="submit-button">등록</button>
				</form>
				<script>

				      document.getElementById('sellerSubmitBtn').addEventListener('click', function(event) {
	                        if (confirm('판매 등록하시겠습니까?')) {
                                document.getElementById('registerBookForm').submit();
	                        }
	                    });
				      function registerBook(title, author) {
				            $('#book-title').val(title);
				            $('#book-author').val(author);
				            $('html, body').animate({ scrollTop: $('#registerBookForm').offset().top }, 'slow');
				        }

				        $('#registerBookForm').submit(function(event) {
				            if (!confirm('중고책을 등록하시겠습니까?')) {
				                event.preventDefault();
				            }
				        });
            </script>
				<div class="selling-info">
					<h3>소장하고 계신 중고 상품을 실속있게 판매해 보세요!</h3>
					<div class="selling-options"></div>
				</div>
			</section>
			<section class="all-books">
				<h2>중고책 전체 목록</h2>
				<%
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
				int allCurrentPage = 1;
				int allItemsPerPage = 4; // 페이지당 항목 수
				List<Book> allBooks = new ArrayList<>();
				int allTotalPages = 0;

				try {
					if (request.getParameter("allPage") != null) {
						allCurrentPage = Integer.parseInt(request.getParameter("allPage"));
					}
					int allStartIndex = (allCurrentPage - 1) * allItemsPerPage;

					String allSql = "SELECT * FROM books LIMIT ?, ?";
					conn = DriverManager.getConnection("jdbc:mysql://10.100.205.92:3306/baskin", "used", "1234");
					stmt = conn.prepareStatement(allSql);
					stmt.setInt(1, allStartIndex);
					stmt.setInt(2, allItemsPerPage);
					rs = stmt.executeQuery();
					while (rs.next()) {
						Book book = new Book();
						book.setBook_no(rs.getInt("book_no"));
						book.setBook_id(rs.getString("book_id"));
						book.setTitle(rs.getString("title"));
						book.setAuthor(rs.getString("author"));
						book.setPublisher(rs.getString("publisher"));
						book.setBook_memo(rs.getString("book_memo"));
						book.setNew_old_ebook(rs.getString("new_old_ebook"));
						book.setPrice(rs.getInt("price"));
						book.setStock(rs.getInt("stock"));
						book.setCategory_overseas(rs.getString("category_overseas"));
						book.setCategory_age(rs.getString("category_age"));
						book.setCategory_all(rs.getString("category_all"));
						book.setInsert_day(rs.getDate("insert_day"));
						book.setBook_fileName(rs.getString("book_fileName"));
						book.setSeller_id(rs.getInt("seller_id"));

						allBooks.add(book);
					}

					rs.close();
					stmt.close();
					String allCountSql = "SELECT COUNT(*) AS count FROM books";
					stmt = conn.prepareStatement(allCountSql);
					rs = stmt.executeQuery();
					if (rs.next()) {
						int totalItems = rs.getInt("count");
						allTotalPages = (int) Math.ceil(totalItems / (double) allItemsPerPage);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (rs != null)
						try {
					rs.close();
						} catch (SQLException e) {
					e.printStackTrace();
						}
					if (stmt != null)
						try {
					stmt.close();
						} catch (SQLException e) {
					e.printStackTrace();
						}
					if (conn != null)
						try {
					conn.close();
						} catch (SQLException e) {
					e.printStackTrace();
						}
				}

				request.setAttribute("allBooks", allBooks);
				request.setAttribute("allCurrentPage", allCurrentPage);
				request.setAttribute("allTotalPages", allTotalPages);
				%>

				<c:forEach var="book" items="${allBooks}">
					<article class="book-item" onclick="moveDetail(${book.book_id});">
						<img src="${book.book_fileName}" alt="${book.title}">
						<h3>${book.title}</h3>
						<p>저자: ${book.author}</p>
						<p>가격: ${book.price} 원</p>
					</article>
				</c:forEach>

				<div class="pagination">
					<c:if test="${allCurrentPage > 1}">
						<a
							href="${pageContext.request.contextPath}/used/used_books.jsp.jsp?allPage=${allCurrentPage - 1}">이전</a>
					</c:if>
					<c:forEach var="i" begin="1" end="${allTotalPages}">
						<c:choose>
							<c:when test="${i == allCurrentPage}">
								<span class="current-page">${i}</span>
							</c:when>
							<c:otherwise>
								<a
									href="${pageContext.request.contextPath}/used/used_books.jsp?allPage=${i}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${allCurrentPage < allTotalPages}">
						<a
							href="${pageContext.request.contextPath}/used/used_books.jsp?allPage=${allCurrentPage + 1}">다음</a>
					</c:if>
				</div>
			</section>
			<section class="special-section">
				<article class="special-item">
					<h2>부산IT 직배송 중고</h2>
					<p>
						싸고 믿을 수 있고 총알배송까지!<br>부산IT 직배송 중고도서 둘러보세요!
					</p>
					<img src="https://via.placeholder.com/150" alt="부트스트랩">
				</article>
				<article class="special-item">
					<h2>소장용 상품</h2>
					<p>
						소장가치가 높은 특별한 중고상품을<br>만나보세요!
					</p>
					<img src="https://via.placeholder.com/150" alt="파이썬">
				</article>
				<article class="special-item">
					<h2>중고상품 판매요청</h2>
					<p>
						불필요한 중고 도서를 판매하여 수익을<br>창출해보세요!
					</p>
					<img src="https://via.placeholder.com/150" alt="자바스크립트">
				</article>
			</section>
		</div>
	</main>

	<script src="${pageContext.request.contextPath}/used/script.js"></script>
	<script>
    function moveDetail(bookId){
        const referer = window.location.href;
        location.href = "${pageContext.request.contextPath}/used/usedBooksdetail.jsp?bookId=" + bookId + "&referer=" + encodeURIComponent(referer);
    }
</script>
</body>
</html>