<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>중고 도서 판매 - 배스킨라빈스31.2</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <header>
       
    </header>

    <main>
        <div class="top-bar">
            <div class="logo">베스킨라빈스31.2</div>
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="통합검색">
                <button class="search-button">Q</button>
            </div>
        </div>
        <div class="header">
            <h1>중고샵</h1>
            <p>해외 직배송 도서 모음!</p>
        </div>
        <div class="container">
            <div class="category">
                <h2>카테고리</h2>
                <ul>
                    <li class="category">
                        <button class="category-title" onclick="toggleDropdown('foreign-books')">중고 외국도서
                            <i class="arrow down"></i>
                        </button>
                        <ul id="foreign-books" class="subcategory-list">
                            <li><a href="#">ELT/사전</a></li>
                            <li><a href="#">유아/어린이</a></li>
                            <li><a href="#">문학/소설</a></li>
                            <li><a href="#">경영/인문</a></li>
                            <li><a href="#">예술/실용</a></li>
                            <li><a href="#">컴퓨터</a></li>
                            <li><a href="#">자연과학</a></li>
                            <li><a href="#">일본도서</a></li>
                            <li><a href="#">프랑스도서</a></li>
                            <li><a href="#">중국도서</a></li>
                            <li><a href="#">해외잡지</a></li>
                            <li><a href="#">대학교재/전문서적</a></li>
                            <li><a href="#">Outlet Store</a></li>
                            <li><a href="#">Books On Korea</a></li>
                        </ul>
                    </li>
                    <li class="category">
                        <button class="category-title" onclick="toggleDropdown('domestic-books')">중고 국내도서
                            <i class="arrow down"></i>
                        </button>
                        <ul id="domestic-books" class="subcategory-list">
                            <li><a href="#">가정 살림</a></li>
                            <li><a href="#">건강 취미</a></li>
                            <li><a href="#">경제 경영</a></li>
                            <li><a href="#">국어 외국어 사전</a></li>
                            <li><a href="#">대학교재</a></li>
                            <li><a href="#">만화/라이트노벨</a></li>
                            <li><a href="#">사회 정치</a></li>
                            <li><a href="#">소설/시/희곡</a></li>
                            <li><a href="#">수험서 자격증</a></li>
                            <li><a href="#">어린이</a></li>
                            <li><a href="#">에세이</a></li>
                            <li><a href="#">역사</a></li>
                            <li><a href="#">예술</a></li>
                            <li><a href="#">유아</a></li>
                            <li><a href="#">인문</a></li>
                            <li><a href="#">인물</a></li>
                            <li><a href="#">자기계발</a></li>
                            <li><a href="#">자연과학</a></li>
                            <li><a href="#">잡지</a></li>
                            <li><a href="#">전집</a></li>
                            <li><a href="#">종교</a></li>
                            <li><a href="#">청소년</a></li>
                            <li><a href="#">IT/모바일</a></li>
                            <li><a href="#">초등참고서</a></li>
                            <li><a href="#">중고등참고서</a></li>
                        </ul>
                    </li>


                </ul>
            </div>

            <section class="used-book-upload">
                <div class="container">
                    <h2>중고 도서 판매</h2>
                    <div class="upload_desc">
                        <p>판매하실 도서의 정보를 입력해주세요.</p>
                    </div>
                    <form id="used-book-form">
                        <div class="form-row">
                            <label for="book-search">도서 검색:</label>
                            <div class="search-bar">
                                <input type="text" id="book-search" placeholder="도서명 또는 ISBN 입력">
                                <button type="button" id="search-button">검색</button>
                            </div>
                        </div>

                        <div id="book-info" style="display: none;">
                            <div class="book-image">
                                <img id="book-cover" src="" alt="책 표지">
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
                    </form>

                    <div class="selling-info">
                        <h3>소장하고 계신 중고 상품을 실속있게 판매해 보세요!</h3>
                        <div class="selling-options">
                            <div class="selling-option">
                                <img src="buyback.png" alt="바이백">
                                <p>배스킨라빈스에 팔기</p>
                            </div>
                            <div class="selling-option">
                                <img src="my-store.png" alt="내 가게">
                                <p>내 가게에서 팔기</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <h2>인기 중고도서 상품</h2>
            <div class="book-item">
                <img src="book1.jpg" alt="Book 1">
                <h3>Book 1 Title</h3>
                <p>Author: 최기근</p>
                <p>Price: $90.00</p>
            </div>
            <div class="book-item">
                <img src="book2.jpg" alt="Book 2">
                <h3>Book 2 Title</h3>
                <p>Author: 최기근</p>
                <p>Price: $25.00</p>
            </div>
            <div class="book-item">
                <img src="book3.jpg" alt="Book 3">
                <h3>Book 3 Title</h3>
                <p>Author: 최기근</p>
                <p>Price: $20.00</p>
            </div>
            <div class="book-item">
                <img src="book4.jpg" alt="Book 4">
                <h3>Book 4 Title</h3>
                <p>Author: 최기근</p>
                <p>Price: $85.00</p>
            </div>

            <div class="store-section">
                <h2>추천 헌책방</h2>
                <div class="store-list">
                    <div class="store-item">
                        <h3>베스킨 헌책방</h3>
                        <img src="store1.jpg" alt="베스킨 헌책방">
                        <p>30,000원 이상 무료배송</p>
                        <p>판매자: 최기근</p>
                    </div>
                    <div class="store-item">
                        <h3>JSP</h3>
                        <img src="store2.jpg" alt="JSP">
                        <p>100,000원 이상 무료배송</p>
                        <p>판매자: 최기근</p>
                    </div>
                    <div class="store-item">
                        <h3>HTML</h3>
                        <img src="store3.jpg" alt="HTML">
                        <p>25,000원 이상 무료배송</p>
                        <p>판매자: 최기근</p>
                    </div>
                    <div class="store-item">
                        <h3>스프링</h3>
                        <img src="store4.jpg" alt="스프링">
                        <p>70,000원 이상 무료배송</p>
                        <p>판매자: 최기근</p>
                    </div>
                    <div class="store-item">
                        <h3>CSS</h3>
                        <img src="store5.jpg" alt="CSS">
                        <p>30,000원 이상 무료배송</p>
                        <p>판매자: 최기근</p>
                    </div>
                </div>
            </div>

            <div class="special-section">
                <div class="special-item">
                    <h2>부산IT 직배송 중고</h2>
                    <p>싸고 믿을 수 있고 총알배송까지!<br>부산IT 직배송 중고도서 둘러보세요!</p>
                    <img src="book1.jpg" alt="부트스트랩">
                    <p>부트스트랩</p>
                    <p>15000원</p>
                    <p>새상품 대비 33% 할인</p>
                </div>
                <div class="special-item">
                    <h2>소장용 상품</h2>
                    <p>소장가치가 높은 특별한 중고상품을<br>만나보세요!</p>
                    <img src="book2.jpg" alt="파이썬">
                    <p>파이썬</p>
                    <p>제어문 컬렉션</p>
                    <p>45,000원</p>
                </div>
                <div class="special-item">
                    <h2>중고상품 판매요청</h2>
                    <p>찾는 상품이 중고샵에 없나요?<br>원하는 중고상품을 요청해주세요!</p>
                    <img src="book3.jpg" alt="홈(1Disc)">
                    <p>홈(1Disc)</p>
                    <p>요청건수: 99건</p>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="company-info">
                    <h3>베스킨라빈스31.2(주)</h3>
                    <p>대표: 최기근</p>
                    <p>사업자등록번호: 000-00-00000</p>
                    <p>통신판매업신고: 제 0000-0000호</p>
                    <address>부산 수영구 광남로 70</address>
                    <p>Copyright © 베스킨라빈스31.2 Corp. All Rights Reserved.</p>
                </div>
                <div class="customer-service">
                    <h3>고객센터</h3>
                    <p>0000-0000 (유료)</p>
                    <p>365일 09:00 ~ 18:00</p>
                    <p>점심시간 12:00 ~ 13:00</p>
                    <p><a href="#">1:1 문의하기</a></p>
                </div>
            </div>
        </div>
    </footer>
    <script src="script.js"></script>
    <script>
        function toggleDropdown(id) {
            var element = document.getElementById(id);
            element.classList.toggle("active");
        }
    </script>
</body>

</html>