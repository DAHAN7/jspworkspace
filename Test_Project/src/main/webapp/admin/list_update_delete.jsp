<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="javax.naming.*, javax.sql.*, java.sql.*, utils.JDBCUtil"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 재고 (수정/삭제) list page</title>
</head>
<style>
	*{
	    margin:0;
	    padding:0;
	}    
	.wrap{
	    width: 1300px;
	    height:1700px;
	    margin:50px auto;
	}
	footer, section {
	    float:left;
	    box-sizing: border-box;
	}
	/* ----------------- */
	/* Second */
	.container {
        padding-left: 350px;
        padding-bottom: 20px;
    	border-bottom: 1px solid gainsboro;
	}
	h1.first span{
	    position: relative;
	    font-weight: 400;
	    font-size: 2.8rem;
	}
	h1.first span:before {
	    content: '';
	    display: block;
	    position: absolute;
	    top: calc(50% + 2px); left: -10px;
	    width: calc(100% + 20px); 
	    height: 25%;
	    transform: translateY(-50%);
        z-index: -1;
	    background-color: pink;
	}
	/* header menu */
	/* header menu */
	header {
		width: 1200px;
	}
	.headermenu {
		padding-left: 60px;
		margin-top: 20px;
		font-size: 1.2rem;
		line-height: 170%;
	}
	a {
		text-decoration-line: none;
		color: blue;
	}
	ul {
		list-style:none;
	}       
	/* header */
	/* header */
	/* 검색창 */
	/* 검색창 */
	.search-txt {
		width: 220px;
		height: 23px;
	}
	.search-btn {
		width: 100px;
		height: 27px;
		margin-left: 0px;
	}
	
	/* 2차 이상의 메뉴만 none 값을 주기 */
	.top-bar__menu-box-1 > ul ul {
	    display: none;
	}
	/* 가운데 정렬 */
	.con {
	    margin-left: 460px;
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
	    margin-top: 5px;
	}
	/* 모든 메뉴 박스의 배경을 검은색으로 하고 글자를 하얀색으로 꾸며보자 */
	.top-bar__menu-box-1 ul {
	    background-color:  white;
	    color: black;
	}
	/* 모든 메뉴 크기 조절 */
	.top-bar__menu-box-1 ul > li > a {
	    display: block;
	    font-size: 1.0rem;
	    padding: 2px 2px;
	    border: 1px solid gainsboro ;
	    width: 110px;
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
	/* table  */
	/* table  */
	.book_update {
		padding-top: 10px;
		padding-left: 55px;
		padding-bottom: 30px;		
	}
	.bimg {
		width: 320px;
		padding-left: 20px;
		padding-right: 20px;
		margin-bottom: 15px;	
	}
	.inform {
		margin-left: 35px;
		margin-top: 25px;
		margin-bottom: 10px;
		width: 80px;
		height: 40px;
	}
	.m_menu {
		padding-left: 10px;
		width: 320px;
		height: 40px;
	    font-size: 1.1rem;
	    text-shadow: 2px 2px 0px #FFFFFF, 
	         	  	 5px 4px 0px rgba(0,0,0,0.15), 
	         	     2px 2px 2px rgba(206,89,55,0);
	}
	.r_menu {
		padding-left: 10px;
		width: 470px;
	    font-size: 1.1rem;
	}
	/* button */
	/* button */
	button {
	  	margin: 10px;
	}
	.custom-btn {
		width: 220px; /* 버튼 가로 */
		height: 40px; /* 버튼 세로 */
	    color: #fff;
	    border-radius: 5px;
   	    padding: 10px 25px;
  	    font-family: 'Lato', sans-serif;
	    font-size: 17px; /* 폰트 크기 */
	    font-weight: 800; /* 폰트 굵기 */
	    font-style: normal;
	    text-shadow: 0px -2px 0px rgba(0,0,0,0.4); /* 폰트 그림자 / 색상 */
	    text-decoration: none;
	    background: transparent;
	    cursor: pointer;
	    position: relative;
	    display: inline-block;
	    box-shadow: inset 0px 1px 0px rgba(255,255,255,1),0px 1px 3px rgba(0,0,0,0.3);
	    outline: none;
	    border: 1px solid #ba6;
	}
	.custom-btn:active{
	    -webkit-transform: translateY(2px);
	    transform: translateY(2px);
	}
	.btn-9{
	    backface-visibility: hidden;
	    position: relative;
	    cursor: pointer;
	    display: inline-block;
	    white-space: nowrap;
	    border-color: #D9A3A9;
	    background: linear-gradient(180deg,#FFE6E9 0%,#DDA6AE 49%, #B76E79 51%,#DDA6AE 100%);
	    border-radius: 5px;
	}	
	/* footer  */
	/* footer  */
	footer {
	    background:white;
	    width: 1300px;
	    height: 100px;
	    text-align: center;
	    padding-top: 40px;
	    border-top: 1px solid gainsboro;
	}
</style>
<body>
			    <% 
			    	int memberType = (Integer) session.getAttribute("memberType");
			    	if(memberType != 2){
			    %>
				    <script >
		    			location.href="../member/login.jsp"
				    </script>
				<%
			    	}
				%>
    <div class="wrap">
		<div class="container">
			<h1 class="first"><span>관리자 재고 (수정/삭제) list page</span></h1>
		</div>
		<header>
			<div class="headermenu">
				<ul>
					<li><a href="insert_form.jsp">☛ 관리자 재고 insert page </a></li>
					<li><a href="회원관리.jsp">☛ 회원관리 page </a></li>
					<li><a href="../index.jsp">☛ 판매 main page </a></li>
				</ul>
			</div>
		</header>
		<div class="con">
              <nav class="top-bar__menu-box-1">
                <ul>
                    <li>
                        <form class="search-box" action="검색페이지로이동" method="get">
                            <input class="search-txt" type="text" placeholder="검색어를 입력하세요." />
                            <button class="search-btn" type="submit ">수정할 책 찾기</button>
                        </form>
                    </li>
                    <li>
                        <a href="#">연령대</a>
                        <ul>
                            <li><a href="#">10대</a></li>
                            <li><a href="#">20대</a></li>
                            <li><a href="#">30대</a></li>
                            <li><a href="#">40대</a></li>
                            <li><a href="#">50대 +</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">품절 유무</a>
                        <ul>
                            <li><a href="#">품절 제품</a></li>
                            <li><a href="#">모두 보기</a></li>
                        </ul>
                    </li>
                    <li id="seemenu">
                        <a href="#">메뉴수량설정</a>
                        <ul>
                            <li><a href="#">12개씩 보기</a></li>
                            <li><a href="#">36개씩 보기</a></li>
                            <li><a href="#">72개씩 보기</a></li>
                        </ul>
                    </li>
                </ul>
              </nav>
        </div>
<%
	// JDBCUtil 정보 연결
	Connection conn = JDBCUtil.getConnection();
	// 데이터베이스에 SQL문을 전달하는 PreparedStatement 객체
	PreparedStatement pstmt = null;
	// 데이터베이스로부터 결과값을 전달받는 ResultSet 객체 
	ResultSet rs = null;

	try {
		// SQL문 작성하고 실행하기
		String sql = " SELECT * FROM books ";
		// JDBC받은 정보와 함께 SQL문 저장
		pstmt = conn.prepareStatement(sql);
		// executeQuery() 행의 정보를 받는다.
		rs = pstmt.executeQuery();
		// next() 첫행 반복 출력
		while (rs.next()) {
			
			String book_fileName = rs.getString("book_fileName");
			System.out.println(book_fileName);	
			
%>    
    	<div class="book_update">
		    <table border="1">
		        <tr>
		            <td rowspan="14" style="width:210px;">
						<img class="bimg" src="img/<%=rs.getString("book_fileName")%>" onerror="this.onerror=null; this.src='img/noimages.png';" />
						<!-- 수정 버튼-->
                        <div>
                        	<center>
                        		<a href="book_update_form.jsp?book_no=<%= rs.getString("book_no") %>"><button class="custom-btn btn-9">수정하기</button></a>
                        	</center>
                        </div>
	                	<!-- 삭제 버튼 -->
                        <div>
                        	<center>
                        		<a href="book_delete.jsp?book_no=<%= rs.getString("book_no") %>"><button class="custom-btn btn-9">삭제하기</button></a>
                        	</center>
                        </div>   	
		            </td>
		            <td class="m_menu">title (책 이름)</td>
		            <td class="r_menu"><%= rs.getString("title") %></td>
		        </tr>
		        <tr>
		            <td class="m_menu">book_no (제품 고유 넘버)</td>
		            <td class="r_menu"><%= rs.getString("book_no") %>
		            	<del style="color: red;"><small> 수정불가항목</small></del>
		            </td>
		        </tr>
		        <tr>
		            <td class="m_menu">book_id (제품 등록 ID)</td>
		            <td class="r_menu"><%= rs.getString("book_id") %></td>
		        </tr>
		        <tr>
		            <td class="m_menu">author (저자)</td>
		            <td class="r_menu"><%= rs.getString("author") %></td>
		        </tr>
		        <tr>
		            <td class="m_menu">publisher (출판사)</td>
		            <td class="r_menu"><%= rs.getString("publisher") %></td>
		        </tr>
		        <tr>
		            <td class="m_menu">book_memo (한줄 소개)</td>
		            <td class="r_menu"><%= rs.getString("book_memo") %></td>
		        </tr>  
		        <tr>
		            <td class="m_menu">new_old_ebook (신품/중고/e-book)</td>
		            <td class="r_menu"><%= rs.getString("new_old_ebook") %></td>
		        </tr>    
		        <tr>
		            <td class="m_menu">price (제품 가격)</td>
		            <td class="r_menu">   
		            <!-- price 천단위 변환 -->
		            	<fmt:formatNumber pattern="#,###" > 
							<%= rs.getString("price") %>
						</fmt:formatNumber>
		            원
		            </td>
		        </tr>
		        <tr>
		            <td class="m_menu">stock (입고 수량)</td>
		            <td class="r_menu"> 
		            <!-- stock 천단위 변환 -->  
		            	<fmt:formatNumber pattern="#,###" > 
							<%= rs.getString("stock") %>
						</fmt:formatNumber>
		            개
		            </td> 
		        </tr>
		        <tr>
		            <td class="m_menu">category_overseas (국내/외 구분)</td>
		            <td class="r_menu"><%= rs.getString("category_overseas") %></td>
		        </tr>
		        <tr>
		            <td class="m_menu">category_age (연령대 구분)</td>
		            <td class="r_menu"><%= rs.getString("category_age") %></td>
		        </tr>
		        <tr>
		            <td class="m_menu">category_all (대분류)</td>
		            <td class="r_menu"><%= rs.getString("category_all") %></td>
		        </tr>
		        <tr>
		            <td class="m_menu">insert_day (최초 등록한 날짜)</td>
		            <td class="r_menu"><%= rs.getString("insert_day") %>
		            	<del style="color: red;"><small> 수정불가항목</small></del>
		            </td>
		        </tr>	        
		        <tr>
		            <td class="m_menu">book_fileName (이미지 파일 이름)</td>
		            <td class="r_menu" ><%= rs.getString("book_fileName") %></td>
		        </tr>
		    </table>
	    </div>
<%
		} // end while
	}catch(Exception e){
		e.getMessage();
	} finally{
		// 가변형 인자열에 .close 전달
		JDBCUtil.close(pstmt, conn, rs);
	}
%>
		<footer>
            <p>Copyright © 베스킨라빈스31.2 Corp. All Rights Reserved.</p>
            <p>고객센터 0000-0000 (유료) 365일 09:00 ~ 18:00 </p>
        </footer>   
	</div>
</body>
</html>







