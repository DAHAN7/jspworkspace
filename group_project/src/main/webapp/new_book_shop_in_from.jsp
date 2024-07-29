<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.JDBCUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>main 상세 page</title>
<style>
	aside, section {
	    float:left;
	    box-sizing: border-box;
	}
	footer {
	    float:left;
	}
	*{
	    margin:0;
	    padding:0;
	}    
	ul, ol{
	    list-style:none;
	}
	.wrap{
	    width: 1300px;
	    height:1700px;
	    margin:50px auto;
	}
	/* header */
	/* header */
	/* header */
	header{
	    width:1000px;
	    height:60px;
	    padding-left: 110px;
	    padding-top: 30px;
	    border-bottom: 1px solid gainsboro;
	}
	header > nav > ul > li{
	    float:left;
	    width:185px;
	    height:45px;
	    box-sizing:border-box;
	    text-align:center;
	    font-size:medium;
	    letter-spacing: 2px;
	    line-height:50px;
	    
	}
	header > nav > ul > li > .inner_menu{
	    position:absolute;
	    width:185px;
	    background-color:rgba(255,255,255,0.8);
	    height:0;
	    overflow:hidden;
	    transition:all 0.3s linear;
	}
	header > nav > ul:hover > li .inner_menu{
	    height:150px;
	}
	/* header */
	/* header */
	/* header */
	/* 검색창 */
	/* 검색창 */
	/* 검색창 */
	/* 2차 이상의 메뉴만 none 값을 주기 */
	.top-bar__menu-box-1 > ul ul {
	    display: none;
	}
	/* 가운데 정렬 */
	.con {
	    margin-left: 344px;
	}
	/* 실질적으로 메뉴에 사용할 너비 설정 */
	.top-bar > .con {
	    width: 800px;
	    height: 50px;
	    float: right;
	}
	/* 실질적으로 메뉴에 사용할 너비 설정 */
	.top-bar__menu-box-1 > ul > li {
	    display: inline-block;
	}
	/* 문자열 가운데 정렬 */
	.top-bar__menu-box-1 {
	    text-align: center;
	    margin-top: 20px;
	}
	/* 모든 메뉴 박스의 배경을 검은색으로 하고 글자를 하얀색으로 꾸며보자 */
	.top-bar__menu-box-1 ul {
	    background-color:  white;
	    color: black;
	}
	/* 모든 메뉴 크기 조절 */
	.top-bar__menu-box-1 ul > li > a {
        display: block;
        font-size: 0.9rem;
        padding: 2px 2px;
        border: 1px solid gainsboro ;
        width: 90px;
	}
	/* 모든 메뉴를 마우스 인식 시 배경색을 변경 */
	.top-bar__menu-box-1 ul > li:hover > a {
	    background-color: rgba(80, 147, 236, 0.352);
	    opacity: 0.8;
	}
	/* 2차 메뉴가 보이도록 만들어 보자 */
	.top-bar__menu-box-1 > ul > li:hover > ul {
	    display: block;
	}
	/* 1차 메뉴를 제한 구역으로 설정 */
	.top-bar__menu-box-1 > ul > li {
	    position: relative;
	}
	/* 2차 메뉴에 absolute 값을 주기 */
	.top-bar__menu-box-1 > ul > li > ul {
	    position: absolute;
	    top: 100%;		/* 2차 메뉴를 1차 메뉴의 아래에 위치시킨다 */
	    left: 0;		/* 2차 메뉴를 1차 메뉴의 왼쪽 벽에 붙인다 */
	    width: 100%;		/* 부모의 너비를 그대로 받아온다 */
	}
	/* logo */
	/* logo */
	/* logo */
	.mlogo {
	    padding-left: 120px;
	    padding-bottom: 20px;
	}
	.logo {
	    width:60px;
	    height:60px;
	    border-radius:50%;
	    display: inline-block;
	    opacity: 0.6;
	    padding-left: 10px;
	    animation: logo 1.5s ease-in-out infinite;
	}
	@keyframes logo {
	    0% {
	        transform: scale(1);
	    }
	    25% {
	        transform: scale(1.2);
	    }
	    50% {
	        transform: scale(1);
	    }
	    75% {
	        transform: scale(1.2);
	    }
	    100% {
	        transform: scale(1);
	    }
	}  
	.logotext {
	    width:750px;
	    display: inline-block;
	    font-size: 3.5rem;
	    text-align: center;
	    letter-spacing: -5px;
	    word-spacing: 10px;
	    text-shadow: -5px -5px 5px black;
	    color: palevioletred;
	    opacity: 0.7;
	    padding-left: 10px;
	}
	/* aside */
	/* aside */
	/* aside */
	#aside{
	    width: 120px;
	    padding-top: 50px;
	    padding-left: 10px;
	}
	.bestseller {
	    width: 80px;
	    height: 130px;
	    font-size: 1.4rem;
	    font-weight:500;
	    letter-spacing: 3px;
	    line-height:30px;
	    font-style: italic;
	    padding: 20px;
	    transition: all 0.5s;
	    background-color: rgba(244, 147, 179, 0.352);
	    opacity: 0.8;
	    border-radius:5%;
	    border: 1px solid grey;
	}
	aside nav ul li:hover{
	    background-color: rgba(80, 147, 236, 0.352);
	    cursor: pointer;
	    transform: translateX(20px);
	    border-radius:5%;
	}
	aside nav ul li:hover a{
	    color: rgb(12, 12, 45);
	}
	/* section */
	/* section */
	/* section */
	a {
	    text-decoration-line: none;
	    color: black;
	}
	#section {
	    width: 1100px;
	    padding-left: 50px;
	    padding-top: 20px;
	    padding-bottom: 50px;
	}
	.book {
	    float:left;
	    width: 460px;
	    height: 750px;
	    margin: 2px 10px 10px 2px;
	    padding-top: 20px;
	}
	.book2 {
	    float:left;
	    width: 460px;
	    height: 330px;
	    margin: 2px 10px 10px 2px;
	    padding-left: 10px;
	    border-bottom: 1px solid gainsboro;
	    padding-top: 50px;
	}
	.book3 {
	    float:left;
	    width: 460px;
	    height: 376px;
	    margin: 2px 10px 10px 2px;
	    padding-left: 10px;
	}
	.bimg {
	    width: 430px;
	    height: 600px;
	    display: block;
	    margin: auto;
	    padding-top: 25px;
	}
	.inform {
	    margin-top: 40px;
	    margin-left: 30px;
	    width: 180px;
	    height: 50px;
	    background-color: white;
	    font-size: 0.9rem;
	    font-weight:600;
	    border: 1px solid gray;
	}
	.saleinfor {
	    margin-top: 10px;
	}
	.salebutton {
	    margin-left: 40px;
	    width: 230px;
	    height: 50px;
	    background-color: rgba(80, 148, 236, 0.722);
	    color: white;
	    font-size: 1.1rem;
	    font-weight:500;
	    border: none;
	    margin-bottom: 40px;
	}
	.salebutton2 {
	    margin-top: 20px;
	    margin-left: 10px;
	    width: 130px;
	    height: 50px;
	    background-color: rgba(50, 182, 202, 0.722);
	    color: white;
	    font-size: 1.1rem;
	    font-weight:500;
	    border: none;
	}
	.stock {
	    margin-top: 40px;
	    padding-left: 10px;
	    font-size: 1.2rem;
	}
	/* 수량버튼 */
	/* 수량버튼 */
	/* 수량버튼 */
	.count-wrap_count {
	    padding-left: 39px;
	    padding-top: 50px;
	}
	.minus{
	    width: 25px;
	    height: 25px;
	    margin-left: 10px;
	}
	.inp{
	    width: 40px;
	    height: 21px;
	    text-align: center;
	}
	.plus{
	    width: 25px;
	    height: 25px;
	}
	.btitle {
	    padding-left: 15px;
	    padding-top: 15px;
	    font-size: 3.0rem;
	    font-weight:600;
	    text-decoration-line: none;
	}
	.bauthor {
	    padding-left: 15px;
	    padding-top: 5px;
	    font-size: 2.0rem;
	}
	.bpublisher {
	    padding-left: 15px;
	    font-size: 2.0rem;
	}
	.bprice {
	    padding-left: 15px;
	    padding-top: 5px;
	    font-size: 2.5rem;
	    font-weight:500;
	    font-style: italic;
	}
	.bstarscore {
	    padding-left: 15px;
	    padding-top: 5px;
	}
	.star12345 {
	    width: 111px;
	    height: 23px;
	    padding-left: 12px;
	    padding-top: 5px;
	}
	/* footer  */
	/* footer  */
	/* footer  */
	footer {
	    background:white;
	    width: 1200px;
	    height: 100px;
	    text-align: center;
	    padding-top: 40px;
	    border-top: 1px solid gainsboro;
  	}
</style>
</head>
<body>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <div class="wrap">
        <ul class="mlogo">
            <a href="index.jsp"><img class="logo" src="img/31.png" title="31"/></a>
            <a href="index.jsp"><div class="logotext">BASKIN ROBBINS 31.2 bookshop</div></a>
            <a href="indrx.jsp"><img class="logo" src="img/31.png" title="31"/></a>
        </ul>
        <header>
            <nav>
                <ul>
                    <li>
                        <a href="">신상품</a>
                        <ul class="inner_menu">
                            <li><a href="">월별 판매순</a></li>
                            <li><a href="">누적 판매순</a></li>
                            <li><a href="">평점순</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="">종합</a>
                        <ul class="inner_menu">
                            <li><a href="">월별 판매순</a></li>
                            <li><a href="">누적 판매순</a></li>
                            <li><a href="">평점순</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="">국내</a>
                        <ul class="inner_menu">
                            <li><a href="">월별 판매순</a></li>
                            <li><a href="">누적 판매순</a></li>
                            <li><a href="">평점순</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="">해외</a>
                        <ul class="inner_menu">
                            <li><a href="">월별 판매순</a></li>
                            <li><a href="">누적 판매순</a></li>
                            <li><a href="">평점순</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="">e-Book</a>
                        <ul class="inner_menu">
                            <li><a href="">월별 판매순</a></li>
                            <li><a href="">누적 판매순</a></li>
                            <li><a href="">평점순</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </header>
        <div class="con">
              <nav class="top-bar__menu-box-1">
                <ul>
                    <li>
                        <form class="search-box" action="searchindex.jsp" method="POST">
                            <input class="search-txt" name="search_txt" type="text" placeholder="검색어를 입력하세요." />
                            <a href="searchindex.jsp"><button class="search-btn" type="submit ">책찾기</button></a>
                        </form>
                    </li>
                    <li>
                        <a href="#">성별</a>
                        <ul>
                            <li><a href="#">여성</a></li>
                            <li><a href="#">남성</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">연령별</a>
                        <ul>
                            <li><a href="#">10대</a></li>
                            <li><a href="#">20대</a></li>
                            <li><a href="#">30대</a></li>
                            <li><a href="#">40대</a></li>
                            <li><a href="#">50대</a></li>
                            <li><a href="#">60대 이상</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">품절유무</a>
                        <ul>
                            <li><a href="#">품절포함</a></li>
                            <li><a href="#">품절제외</a></li>
                        </ul>
                    </li>
                    <li id="seemenu">
                        <a href="#">메뉴수량설정</a>
                        <ul>
                            <li><a href="#">12개씩 보기</a></li>
                            <li><a href="#">36개씩 보기</a></li>
                            <li><a href="#">72개씩 보기</a></li>
                            <li><a href="#">144개씩 보기</a></li>
                        </ul>
                    </li>
                </ul>
              </nav>
        </div>
        <aside id="aside">
            <nav>
                <ul>
                    <li class="bestseller"><a href="">베스트셀러</a></li>
                    <li class="bestseller"><a href="">국내 베스트셀러</a></li>
                    <li class="bestseller"><a href="">해외 베스트셀러</a></li>
                    <li class="bestseller"><a href="">e-Book 배스트셀러</a></li>
                </ul>
            </nav>
        </aside>        
<%
	// request.getParameter()
	// String >>> int 변환
	// 데이터베이스에 SQL문을 전달하는 PreparedStatement 객체
	PreparedStatement pstmt = null;
	// 데이터베이스로부터 결과값을 전달받는 ResultSet 객체 
	ResultSet rs = null;
	// JDBCUtil 정보 연결
	Connection conn = JDBCUtil.getConnection();
	int book_no = Integer.parseInt(request.getParameter("book_no"));
	int stock = 0;
	try {
		// SQL문 작성하고 실행하기
		String sql = " SELECT * FROM books WHERE book_no =" +book_no;
		// JDBC받은 정보와 함께 SQL문 저장
		pstmt = conn.prepareStatement(sql);
		// executeQuery() 행의 정보를 받는다.
		rs = pstmt.executeQuery();
		// next() 첫행 반복 출력
		while (rs.next()) {
            String title = rs.getString("title");
            String author = rs.getString("author");
            String publisher = rs.getString("publisher");
            int price = rs.getInt("price");
            stock = rs.getInt("stock");
%>  
        <section id="section">
            <div class="book">
                	<img class="bimg" src="img/<%=rs.getString("book_fileName")%>" 
                	title="<%=title%>"
                	onerror="this.onerror=null; this.src='img/noimages.png';"/>
                </a>
                <a href=""><input class="inform" type="button" value="재고 입고시 알림 신청" /></a>
                <a href=""><input class="inform" type="button" value="e-Book 출간 알림 신청" /></a>
            </div> 
            <div class="book2">
                	<div class="btitle"><%=title%></div>
                	<div class="bauthor"><%=author%></div>
                	<div class="bpublisher"><%=publisher%></div>
                	<div class="bprice"><%=price%> 원</div>
                	<div class="bstarscore">9.6점(174건)</div>
                	<img class="star12345" src="img/star4.png"/>
            </div> 
            <div class="book3">
                <div class="stock">판매중</div>
                <div class="count-wrap_count">
                    수량 
                    <button type="button" class="minus">-</button>
                    <input type="text" class="inp" value="1" />
                    <button type="button" class="plus">+</button>
                </div>
                <input type="hidden" class="quantity" name="quantity" value="1">
                <input type="hidden" id="stock" value="<%= rs.getInt("stock") %>">
                <% 
                	String userId = (String) session.getAttribute("userId");
                	int memberNum;
                	memberNum = (Integer) session.getAttribute("memberNum");
	                if(userId != null){
	                	
				%>
                <button type="button" class="salebutton" onclick="buyNow('<%= memberNum %>', '<%= book_no %>', '<%=title%>', '<%= price %>')">바로구매</button>
                <button type="button" class="salebutton2" onclick="addToCart('<%= memberNum %>', '<%= book_no %>', $('.quantity').val(), '<%= title %>', '<%= price %>')">장바구니</button>
                <%
	                }
               	%>
                <div class="saleinfor"> - 해외배송 가능</div>
                <div class="saleinfor"> - 최저가 보상</div>
                <div class="saleinfor"> - 동백전 사용가능</div>
            </div> 
        </section> 

<%
		} // end while
	}catch(Exception e){
		e.getMessage();
	} finally{
		// 가변형 인자열에 .close 전달
		JDBCUtil.close(pstmt, conn, rs);
	}
%>	
     
    </div>
        <script>
    function buyNow(memberNum, book_id, title, price) {
        var quantity = $('.quantity').val();
        addToCart(memberNum, book_id, quantity, title, price, true);
    }
    
    function addToCart(memberNum, book_no, quantity, title, price, isBuyNow = false) {
        var stock = parseInt($('#stock').val());
        if (quantity > stock) {
            Swal.fire({
                icon: 'error',
                title: '재고 부족!',
                text: '선택하신 수량이 재고량을 초과하였습니다. 현재 재고: ' + stock,
                showConfirmButton: true
            });
            return;
        }

        $.post('buy/add_to_cart.jsp', { memberNum: memberNum, book_no: book_no, quantity: quantity, title: title, price: price }, function(data) {
            if (data.trim() === "success") {
                if (isBuyNow) {
                    window.location.href = 'buy/payment.jsp?memberNum=' + memberNum;
                } else {
                    var totalPrice = price * quantity;
                    Swal.fire({
                        icon: 'success',
                        title: '장바구니에 추가되었습니다!',
                        text: title + " " + quantity + "개, 총 " + totalPrice + "원에 장바구니에 추가되었습니다!",
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '장바구니 추가 실패!',
                    text: '다시 시도해주세요.',
                    showConfirmButton: true
                });
            }
        });
    }

    $(document).ready(function() {
        $('.plus').click(function() {
            var input = $(this).siblings('.inp');
            var currentValue = parseInt(input.val());
            input.val(currentValue + 1);
            $('.quantity').val(currentValue + 1);
        });

        $('.minus').click(function() {
            var input = $(this).siblings('.inp');
            var currentValue = parseInt(input.val());
            if (currentValue > 1) {
                input.val(currentValue - 1);
                $('.quantity').val(currentValue - 1);
            }
        });
    });
    </script>
           <footer>
            <p>Copyright © 베스킨라빈스31.2 Corp. All Rights Reserved.</p>
            <p>고객센터 0000-0000 (유료) 365일 09:00 ~ 18:00 </p>
        </footer>   
</body>
</html>








