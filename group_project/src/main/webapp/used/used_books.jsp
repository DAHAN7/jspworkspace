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
<link rel="stylesheet" href="/group_project/used/style.css">
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
								href="/group_project/used/usedbooklist/UsedBookList.jsp?subcategory=ELT/사전">ELT/사전</a>
							</li>
							<li class="subcategory-item"><a
								href="/group_project/used/usedbooklist/UsedBookList.jsp?subcategory=유아/어린이">유아/어린이</a></li>
						</ul>
					</li>
					<li class="category-item">
						<button class="category-title" data-category="domestic-books">
							중고 국내도서 <i class="arrow down"></i>
						</button>
						<ul id="domestic-books" class="subcategory-list">
							<li class="subcategory-item"><a
								href="/group_project//used/usedbooklist/UsedBookList.jsp?subcategory=자기계발">자기계발</a></li>
							<li class="subcategory-item"><a
								href="/group_project/used/usedbooklist/UsedBookList.jsp?subcategory=예술">예술</a></li>
							<li class="subcategory-item"><a
								href="/group_project/used/usedbooklist/UsedBookList.jsp?subcategory=자기계발">자기계발</a></li>
						</ul>
					</li>
				</ul>
			</nav>

			<section class="used-book-upload">
				<h2>중고 도서 판매</h2>
				<p>등록하실 도서의 정보를 입력해주세요.</p>
				  <% 
                HttpSession Session = request.getSession(false);
                String sessionMemberNum = (session != null) ? (String) session.getAttribute("memberNum") : null;
                %>
				
			 <form id="registerBookForm" action="used/registerBook.jsp" method="POST">
                    <div id="book-info">
                        <div class="book-image">
                            <img id="book-cover" src="https://via.placeholder.com/150" alt="책 표지">
                        </div>
                        <div class="book-details">
                            <div class="form-row">
                                <label for="book-title">도서명:</label> 
                                <input type="text" id="book-title" name="title" maxlength="255" readonly>
                            </div>
                            <div class="form-row">
                                <label for="book-author">저자:</label> 
                                <input type="text" id="book-author" name="author" maxlength="100" readonly>
                            </div>
                            <div class="form-row">
                                <label for="book-publisher">출판사:</label> 
                                <input type="text" id="book-publisher" name="publisher" maxlength="100">
                            </div>
                            <div class="form-row">
                                <label for="book-price">판매 가격:</label> 
                                <input type="number" id="book-price" name="price" min="1000" required> 원
                            </div>
                            <div class="form-row">
                                <label for="book-condition">도서 상태:</label> 
                                <select id="book-condition" name="status" required>
                                    <option value="신책">신책</option>
                                    <option value="중고책">중고책</option>
                                </select>
                            </div>
                            <div class="form-row">
                                <label for="book-description">상세 설명:</label>
                                <textarea id="book-description" name="description"></textarea>
                            </div>
                            <div class="form-row">
                                <label for="book-category">카테고리:</label> 
                                <input type="text" id="book-category" name="category" maxlength="50">
                            </div>
                            <div class="form-row">
                                <label for="book-stock">재고:</label> 
                                <input type="number" id="book-stock" name="stock" min="0" required>
                            </div>
                            <div class="form-row">
                                <label for="book-images">사진 업로드:</label> 
                                <input type="file" id="book-images" name="image_path" multiple accept="image/*">
                            </div>
                            <input type="hidden" id="seller-id" name="seller_id" value="${sessionMemberNum}">
                            <button type="button" class="submit-button" id="sellerSubmitBtn">판매 등록</button>
                        </div>
                    </div>
                </form>
				<script>

				 document.getElementById('sellerSubmitBtn').addEventListener('click', function(event) {
	                    if (confirm('판매 등록하시겠습니까?')) {
	                        let sellerId = document.getElementById('seller-id').value;
	                        let sessionMemberNum = "${sessionMemberNum}"; // JSP 표현식으로 세션 memberNum을 가져옴

	                        if (sellerId !== sessionMemberNum) {
	                            alert('회원 정보가 일치하지 않습니다. 다시 로그인해주세요.');
	                        } else {
	                            document.getElementById('registerBookForm').submit();
	                        }
	                    }
	                });

                function moveDetail(bookId) {
                    const referer = window.location.href;
                    location.href = "/group_project/used/usedBooksdetail.jsp?bookId=" + bookId + "&referer=" + encodeURIComponent(referer);
                }
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
					// 현재 페이지 파라미터 처리
					if (request.getParameter("allPage") != null) {
						allCurrentPage = Integer.parseInt(request.getParameter("allPage"));
					}
					int allStartIndex = (allCurrentPage - 1) * allItemsPerPage;

					// 도서 목록을 페이지네이션을 적용하여 가져오기
					String allSql = "SELECT * FROM books LIMIT ?, ?";
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");
					stmt = conn.prepareStatement(allSql);
					stmt.setInt(1, allStartIndex);
					stmt.setInt(2, allItemsPerPage);
					rs = stmt.executeQuery();
					while (rs.next()) {
						Book book = new Book();
						book.setId(rs.getInt("book_id"));
						book.setTitle(rs.getString("title"));
						book.setAuthor(rs.getString("author"));
						book.setPrice(rs.getInt("price"));
						book.setImagePath(rs.getString("image_path"));
						book.setDescription(rs.getString("description"));
						book.setCategory(rs.getString("category"));
						book.setStock(rs.getInt("stock"));
						book.setStatus(rs.getString("status"));
						allBooks.add(book);
					}

					// 총 항목 수 계산
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
					<article class="book-item" onclick="moveDetail(${book.id});">
						<img src="${book.imagePath}" alt="${book.title}">
						<h3>${book.title}</h3>
						<p>저자: ${book.author}</p>
						<p>가격: ${book.price} 원</p>
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
			<section class="special-section">
				<section class="popular-books">
					<h2>인기 중고도서 상품</h2>
					<%
					int popularCurrentPage = 1;
					int popularItemsPerPage = 4; // 페이지당 항목 수
					List<Book> popularBooks = new ArrayList<>();
					int popularTotalPages = 0;

					try {
						// 현재 페이지 파라미터 처리
						if (request.getParameter("page") != null) {
							popularCurrentPage = Integer.parseInt(request.getParameter("page"));
						}
						int popularStartIndex = (popularCurrentPage - 1) * popularItemsPerPage;

						// 도서 목록을 페이지네이션을 적용하여 가져오기
						String popularSql = "SELECT * FROM books LIMIT ?, ?";
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baskin", "digital", "1234");
						stmt = conn.prepareStatement(popularSql);
						stmt.setInt(1, popularStartIndex);
						stmt.setInt(2, popularItemsPerPage);
						rs = stmt.executeQuery();
						while (rs.next()) {
							Book book = new Book();
							book.setId(rs.getInt("book_id"));
							book.setTitle(rs.getString("title"));
							book.setAuthor(rs.getString("author"));
							book.setPrice(rs.getInt("price"));
							book.setImagePath(rs.getString("image_path"));
							book.setDescription(rs.getString("description"));
							book.setCategory(rs.getString("category"));
							book.setStock(rs.getInt("stock"));
							book.setStatus(rs.getString("status"));
							popularBooks.add(book);
						}

						// 총 항목 수 계산
						rs.close();
						stmt.close();
						String popularCountSql = "SELECT COUNT(*) AS count FROM books";
						stmt = conn.prepareStatement(popularCountSql);
						rs = stmt.executeQuery();
						if (rs.next()) {
							int totalItems = rs.getInt("count");
							popularTotalPages = (int) Math.ceil(totalItems / (double) popularItemsPerPage);
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

					request.setAttribute("currentBooks", popularBooks);
					request.setAttribute("currentPage", popularCurrentPage);
					request.setAttribute("totalPages", popularTotalPages);
					%>

					<c:forEach var="book" items="${currentBooks}">
						<article class="book-item" onclick="moveDetail(${book.id});">
							<img src="${book.imagePath}" alt="${book.title}">
							<h3>${book.title}</h3>
							<p>저자: ${book.author}</p>
							<p>가격: ${book.price} 원</p>
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

	<script src="/group_project/used/script.js"></script>
	<script>
    function moveDetail(bookId){
        const referer = window.location.href;
        location.href = "/group_project/used/usedBooksdetail.jsp?bookId=" + bookId + "&referer=" + encodeURIComponent(referer);
    }
</script>
</body>
</html>