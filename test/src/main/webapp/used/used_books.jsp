<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*, used.Book"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>중고 도서 판매 - 배스킨라빈스31.2</title>
<link rel="stylesheet" href="/test/used/style.css">
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
							<li class="subcategory-item"><a
								href="usedbooklist/UsedBookList.jsp?subcategory=ELT/사전">ELT/사전</a></li>
							<li class="subcategory-item"><a
								href="usedbooklist/UsedBookList.jsp?subcategory=유아/어린이">유아/어린이</a></li>
						</ul>
					</li>
					<li class="category-item">
						<button class="category-title" data-category="domestic-books">
							중고 국내도서 <i class="arrow down"></i>
						</button>
						<ul id="domestic-books" class="subcategory-list">
							<li class="subcategory-item"><a
								href="usedbooklist/UsedBookList.jsp?subcategory=자기계발">자기계발</a></li>
							<li class="subcategory-item"><a
								href="usedbooklist/UsedBookList.jsp?subcategory=예술">예술</a></li>
							<li class="subcategory-item"><a
								href="usedbooklist/UsedBookList.jsp?subcategory=자기계발">자기계발</a></li>
						</ul>
					</li>
				</ul>
			</nav>

			<section class="used-book-upload">
				<h2>중고 도서 판매</h2>
				<p>판매하실 도서의 정보를 입력해주세요.</p>
				<form id="used-book-form">
					<div class="form-row">
						<label for="book-search">도서 검색:</label>
						<div class="search-bar">
							<input type="text" id="book-search" placeholder="도서명 입력">
							<button type="button" id="search-button">검색</button>
						</div>
					</div>
				</form>
				<div id="book-info" style="display: none;">
					<div class="book-image">
						<img id="book-cover" src="https://via.placeholder.com/150"
							alt="책 표지">
					</div>
					<div class="book-details">
						<div class="form-row">
							<label for="book-title">도서명:</label> <input type="text"
								id="book-title" name="title" readonly>
						</div>
						<div class="form-row">
							<label for="book-author">저자:</label> <input type="text"
								id="book-author" name="author" readonly>
						</div>
						<div class="form-row">
							<label for="book-price">판매 가격:</label> <input type="number"
								id="book-price" name="price" min="1000" required> 원
						</div>
						<div class="form-row">
							<label for="book-condition">도서 상태:</label> <select
								id="book-condition" name="condition">
								<option value="best">최상</option>
								<option value="good">상</option>
								<option value="fair">중</option>
								<option value="poor">하</option>
							</select>
						</div>
						<div class="form-row">
							<label for="book-description">상세 설명:</label>
							<textarea id="book-description" name="description"></textarea>
						</div>
						<div class="form-row">
							<label for="book-images">사진 업로드:</label> <input type="file"
								id="book-images" name="image" multiple accept="image/*">
						</div>
						<!-- seller_id를 입력받는 필드를 추가합니다 -->
						<input type="hidden" id="seller-id" name="seller_id"
							value="${sessionScope.sellerId}">
						<button type="button" class="submit-button" id="submitBtn">판매
							등록</button>
					</div>
				</div>

				<script>
                document.getElementById('submitBtn').addEventListener('click', function(event) {
                    if (confirm('중고책을 등록하시겠습니까?')) {
                    	document.getElementById('used-book-form').submit();
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
				int allCurrentPage = 1;
				int allItemsPerPage = 10; // 페이지당 항목 수
				List<Book> allBooks = new ArrayList<>();
				Connection connAll = null;
				PreparedStatement stmtAll = null;
				ResultSet rsAll = null;

				try {
					// 데이터베이스에 연결
					Class.forName("com.mysql.cj.jdbc.Driver");
					connAll = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");

					// 현재 페이지 파라미터 처리
					if (request.getParameter("allPage") != null) {
						allCurrentPage = Integer.parseInt(request.getParameter("allPage"));
					}
					int allStartIndex = (allCurrentPage - 1) * allItemsPerPage;

					// 전체 도서 목록을 페이지네이션을 적용하여 가져오기
					String allSql = "SELECT * FROM books LIMIT ?, ?";
					stmtAll = connAll.prepareStatement(allSql);
					stmtAll.setInt(1, allStartIndex);
					stmtAll.setInt(2, allItemsPerPage);
					rsAll = stmtAll.executeQuery();
					while (rsAll.next()) {
						Book book = new Book();
						book.setId(rsAll.getInt("book_id"));
						book.setTitle(rsAll.getString("title"));
						book.setAuthor(rsAll.getString("author"));
						book.setPrice(rsAll.getDouble("price"));
						book.setImage(rsAll.getString("image"));
						allBooks.add(book);
					}

					// 총 항목 수 계산
					String allCountSql = "SELECT COUNT(*) AS count FROM books";
					stmtAll = connAll.prepareStatement(allCountSql);
					rsAll = stmtAll.executeQuery();
					rsAll.next();
					int allTotalItems = rsAll.getInt("count");
					int allTotalPages = (int) Math.ceil(allTotalItems / (double) allItemsPerPage);

					request.setAttribute("allBooks", allBooks);
					request.setAttribute("allCurrentPage", allCurrentPage);
					request.setAttribute("allTotalPages", allTotalPages);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (rsAll != null)
						try {
					rsAll.close();
						} catch (SQLException e) {
					e.printStackTrace();
						}
					if (stmtAll != null)
						try {
					stmtAll.close();
						} catch (SQLException e) {
					e.printStackTrace();
						}
					if (connAll != null)
						try {
					connAll.close();
						} catch (SQLException e) {
					e.printStackTrace();
						}
				}
				%>

				<c:forEach var="book" items="${allBooks}">
					<article class="book-item" onclick="moveDetail(${book.id});">
						<img src="${book.image}" alt="${book.title}">
						<h3>${book.title}</h3>
						<p>저자: ${book.author}</p>
						<p>가격: ${book.price}</p>
					</article>
				</c:forEach>

				<div class="pagination">
					<c:if test="${allCurrentPage > 1}">
						<a href="?allPage=${allCurrentPage - 1}">이전</a>
					</c:if>
					<c:forEach var="i" begin="1" end="${allTotalPages}">
						<a href="?allPage=${i}"
							class="<c:if test='${i == allCurrentPage}'>active</c:if>">${i}</a>
					</c:forEach>
					<c:if test="${allCurrentPage < allTotalPages}">
						<a href="?allPage=${allCurrentPage + 1}">다음</a>
					</c:if>
				</div>
			</section>

			<section class="popular-books">
				<h2>인기 중고도서 상품</h2>
				<%
				int currentPage = 1;
				int itemsPerPage = 4; // 페이지당 항목 수
				List<Book> books = new ArrayList<>();
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;

				try {
					// 데이터베이스에 연결
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");

					// 현재 페이지 파라미터 처리
					if (request.getParameter("page") != null) {
						currentPage = Integer.parseInt(request.getParameter("page"));
					}
					int startIndex = (currentPage - 1) * itemsPerPage;

					// 도서 목록을 페이지네이션을 적용하여 가져오기
					String sql = "SELECT * FROM books LIMIT ?, ?";
					stmt = conn.prepareStatement(sql);
					stmt.setInt(1, startIndex);
					stmt.setInt(2, itemsPerPage);
					rs = stmt.executeQuery();
					while (rs.next()) {
						Book book = new Book();
						book.setId(rs.getInt("book_id"));
						book.setTitle(rs.getString("title"));
						book.setAuthor(rs.getString("author"));
						book.setPrice(rs.getDouble("price"));
						book.setImage(rs.getString("image"));
						books.add(book);
					}

					// 총 항목 수 계산
					String countSql = "SELECT COUNT(*) AS count FROM books";
					stmt = conn.prepareStatement(countSql);
					rs = stmt.executeQuery();
					rs.next();
					int totalItems = rs.getInt("count");
					int totalPages = (int) Math.ceil(totalItems / (double) itemsPerPage);

					request.setAttribute("currentBooks", books);
					request.setAttribute("currentPage", currentPage);
					request.setAttribute("totalPages", totalPages);
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
				%>

				<c:forEach var="book" items="${currentBooks}">
					<article class="book-item" onclick="moveDetail(${book.id});">
						<img src="${book.image}" alt="${book.title}">
						<h3>${book.title}</h3>
						<p>저자: ${book.author}</p>
						<p>가격: ${book.price}</p>
					</article>
				</c:forEach>

				<div class="pagination">
					<c:if test="${currentPage > 1}">
						<a href="?page=${currentPage - 1}">이전</a>
					</c:if>
					<c:forEach var="i" begin="1" end="${totalPages}">
						<a href="?page=${i}"
							class="<c:if test='${i == currentPage}'>active</c:if>">${i}</a>
					</c:forEach>
					<c:if test="${currentPage < totalPages}">
						<a href="?page=${currentPage + 1}">다음</a>
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

	<script src="/test/used/script.js"></script>
	<script>
        function moveDetail(bookId){
            location.href = "usedBooksdetail.jsp?bookId=" + bookId;
        }
    </script>
</body>
</html>
