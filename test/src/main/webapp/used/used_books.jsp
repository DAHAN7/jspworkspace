<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*, used.Book, used.Store" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                        <button class="category-title" data-category="foreign-books">중고 외국도서
                            <i class="arrow down"></i>
                        </button>
                        <ul id="foreign-books" class="subcategory-list">
                            <li class="subcategory-item"><a href="usedbooklist/UsedBookList.jsp?subcategory=ELT/사전">ELT/사전</a></li>
                            <li class="subcategory-item"><a href="usedbooklist/UsedBookList.jsp?subcategory=유아/어린이">유아/어린이</a></li>
                        </ul>
                    </li>
                    <li class="category-item">
                        <button class="category-title" data-category="domestic-books">중고 국내도서
                            <i class="arrow down"></i>
                        </button>
                        <ul id="domestic-books" class="subcategory-list">
                            <li class="subcategory-item"><a href="usedbooklist/UsedBookList.jsp?subcategory=자기계발">자기계발</a></li>
                            <li class="subcategory-item"><a href="usedbooklist/UsedBookList.jsp?subcategory=예술">예술</a></li>
                            <li class="subcategory-item"><a href="usedbooklist/UsedBookList.jsp?subcategory=자기계발">자기계발</a></li>
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
                            <input type="text" id="book-search" placeholder="도서명 또는 ISBN 입력">
                            <button type="button" id="search-button">검색</button>
                        </div>
                    </div>
                </form>
                <div id="book-info" style="display: none;">
                    <div class="book-image">
                        <img id="book-cover" src="https://via.placeholder.com/150" alt="책 표지">
                    </div>
                    <div class="book-details">
                        <div class="form-row">
                            <label for="book-title">도서명:</label>
                            <input type="text" id="book-title" readonly>
                        </div>
                        <div class="form-row">
                            <label for="book-author">저자:</label>
                            <input type="text" id="book-author" readonly>
                        </div>
                        <div class="form-row">
                            <label for="book-isbn">ISBN:</label>
                            <input type="text" id="book-isbn" readonly>
                        </div>
                        <div class="form-row">
                            <label for="book-price">판매 가격:</label>
                            <input type="number" id="book-price" min="1000" required> 원
                        </div>
                        <div class="form-row">
                            <label for="book-condition">도서 상태:</label>
                            <select id="book-condition" name="book-condition">
                                <option value="best">최상</option>
                                <option value="good">상</option>
                                <option value="fair">중</option>
                                <option value="poor">하</option>
                            </select>
                        </div>
                        <div class="form-row">
                            <label for="book-description">상세 설명:</label>
                            <textarea id="book-description" name="book-description"></textarea>
                        </div>
                        <div class="form-row">
                            <label for="book-images">사진 업로드:</label>
                            <input type="file" id="book-images" name="book-images" multiple accept="image/*">
                        </div>
                        <button type="submit" class="submit-button">판매 등록</button>
                    </div>
                </div>
                
                <div class="selling-info">
                    <h3>소장하고 계신 중고 상품을 실속있게 판매해 보세요!</h3>
                    <div class="selling-options">
                        <div class="selling-option">
                            <img src="https://via.placeholder.com/150" alt="바이백">
                            <p>배스킨라빈스에 팔기</p>
                        </div>
                        <div class="selling-option">
                            <img src="https://via.placeholder.com/150" alt="내 가게">
                            <p>내 가게에서 팔기</p>
                        </div>
                    </div>
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
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdatabase", "username", "password");

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
                            book.setId(rs.getInt("id"));
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
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
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
                        <a href="?page=${i}" class="<c:if test='${i == currentPage}'>active</c:if>">${i}</a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}">다음</a>
                    </c:if>
                </div>
            </section>

            <section class="store-section">
                <h2>추천 헌책방</h2>
                <% 
                    int storePage = 1;
                    int storesPerPage = 5; // 페이지당 헌책방 수
                    List<Store> stores = new ArrayList<>();
                    Connection storeConn = null;
                    PreparedStatement storeStmt = null;
                    ResultSet storeRs = null;

                    try {
                        // 데이터베이스에 연결
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        storeConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdatabase", "username", "password");

                        // 현재 페이지 파라미터 처리
                        if (request.getParameter("storePage") != null) {
                            storePage = Integer.parseInt(request.getParameter("storePage"));
                        }
                        int storeStartIndex = (storePage - 1) * storesPerPage;
                        
                        // 상점 목록을 페이지네이션을 적용하여 가져오기
                        String storeSql = "SELECT * FROM stores LIMIT ?, ?";
                        storeStmt = storeConn.prepareStatement(storeSql);
                        storeStmt.setInt(1, storeStartIndex);
                        storeStmt.setInt(2, storesPerPage);
                        storeRs = storeStmt.executeQuery();
                        while (storeRs.next()) {
                            Store store = new Store();
                            store.setName(storeRs.getString("name"));
                            store.setImage(storeRs.getString("image"));
                            store.setShipping(storeRs.getString("shipping"));
                            store.setSeller(storeRs.getString("seller"));
                            stores.add(store);
                        }

                        // 총 상점 수 계산
                        String storeCountSql = "SELECT COUNT(*) AS count FROM stores";
                        storeStmt = storeConn.prepareStatement(storeCountSql);
                        storeRs = storeStmt.executeQuery();
                        storeRs.next();
                        int totalStores = storeRs.getInt("count");
                        int storeTotalPages = (int) Math.ceil(totalStores / (double) storesPerPage);

                        request.setAttribute("currentStores", stores);
                        request.setAttribute("storePage", storePage);
                        request.setAttribute("storeTotalPages", storeTotalPages);
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (storeRs != null) try { storeRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (storeStmt != null) try { storeStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (storeConn != null) try { storeConn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>

                <c:forEach var="store" items="${currentStores}">
                    <article class="store-item">
                        <h3>${store.name}</h3>
                        <img src="${store.image}" alt="${store.name}">
                        <p>${store.shipping}</p>
                        <p>판매자: ${store.seller}</p>
                    </article>
                </c:forEach>

                <div class="pagination">
                    <c:if test="${storePage > 1}">
                        <a href="?storePage=${storePage - 1}">이전</a>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${storeTotalPages}">
                        <a href="?storePage=${i}" class="<c:if test='${i == storePage}'>active</c:if>">${i}</a>
                    </c:forEach>
                    <c:if test="${storePage < storeTotalPages}">
                        <a href="?storePage=${storePage + 1}">다음</a>
                    </c:if>
                </div>
            </section>
            <section class="special-section">
                <article class="special-item">
                    <h2>부산IT 직배송 중고</h2>
                    <p>싸고 믿을 수 있고 총알배송까지!<br>부산IT 직배송 중고도서 둘러보세요!</p>
                    <img src="https://via.placeholder.com/150" alt="부트스트랩">
                    <p>부트스트랩</p>
                    <p>15000원</p>
                    <p>새상품 대비 33% 할인</p>
                </article>
                <article class="special-item">
                    <h2>소장용 상품</h2>
                    <p>소장가치가 높은 특별한 중고상품을<br>만나보세요!</p>
                    <img src="https://via.placeholder.com/150" alt="파이썬">
                    <p>파이썬</p>
                    <p>제어문 컬렉션</p>
                    <p>45,000원</p>
                </article>
                <article class="special-item">
                    <h2>중고상품 판매요청</h2>
                    <p>불필요한 중고 도서를 판매하여 수익을<br>창출해보세요!</p>
                    <img src="https://via.placeholder.com/150" alt="자바스크립트">
                    <p>자바스크립트</p>
                    <p>혼자서 자바스크립트</p>
                    <p>30,000원</p>
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
