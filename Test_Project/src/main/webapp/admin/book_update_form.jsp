<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.JDBCUtil" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 재고 (수정/삭제) 상세 page</title>
</head>
<body>
<style>
	*{
	    margin:0;
	    padding:0;
	}    
	.wrap{
	    width: 1550px;
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
        padding-left: 410px;
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
		padding-left: 30px;
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
	/* section */
	/* section */
	.inserttable{
	    width: 1500px;
	    height: 700px;
	    font-size: 1.0rem;
	    margin-left: 22px;
	    margin-top: 10px;
	    margin-bottom: 30px;
	}
	.bimg {
		width: 250px;
		padding-left: 10px;
	}
	.inbox {
	    width: 630px;
	    height: 40px;
	    text-align: center;
	}
	.inbox_1 {
	    width: 610px;
	    height: 33px;
	    font-size: 1.1rem;
	    padding-left: 10px;
	    color: blue;
	}
	.inbox_2 {
		width: 280px;
		height: 30px;
	    padding-left: 10px;
	    background-color: #dee2e6;
	    font-size: 1.1rem;
    }
    .r_menu {
     	padding-left: 10px;
    	background-color: #dee2e6;
    	font-size: 1.1rem;
    }
    .inbox_1_not {
 		width: 200px;
	    height: 33px;
	    font-size: 1.1rem;
		padding-left: 35px;
		margin-left: 5px;
		color: blue;
    }
    .inbox_1_not_1 {
    	width: 233px;
    	height: 30px;
    	font-size: 1.1rem;
    	color: blue;
    }
	/* 메뉴폰트 */
	/* 메뉴폰트 */            
	    font-size: 1.0rem;
	    text-shadow: 2px 2px 0px #FFFFFF, 
	          	  	 5px 4px 0px rgba(0,0,0,0.15), 
	          	     2px 2px 2px rgba(206,89,55,0);
	}
	.checkId_1 {
		height: 30px;
		width: 350px;
	}
	.checkId {
		height: 30px;
		width: 75px;
		margin-left: 10px;
	}
	.inbox_c {
		padding-left: 7px; 
	}        
	/* button */
	/* button */
	button {
	  	margin: 5px 0px; 
	}
	.custom-btn {
		width: 250px; /* 버튼 가로 */
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
	    margin-left: 50px;
	    margin-top: 20px;
	    margin-bottom: 20px;
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
	/* radio_new_old_ebook  */
	/* radio_new_old_ebook  */
	.select_new_old_ebook {
	    padding: 4px 0px;
	}
	.select_new_old_ebook input[type=radio]{
	    display: none;
	}
	.select_new_old_ebook input[type=radio]+label{
	    display: inline-block;
	    cursor: pointer;
	    height: 24px;
	    width: 90px;
	    border: 1px solid #333;
	    line-height: 24px;
	    text-align: center;
	    font-weight:bold;
	    font-size:13px;
	}
	.select_new_old_ebook input[type=radio]+label{
	    background-color: #fff;
	    color: #333;
	}
	.select_new_old_ebook input[type=radio]:checked+label{
	    background-color: #333;
	    color: #fff;
	}
	/* radio_category_overseas  */
	/* radio_category_overseas  */
	.select_category_overseas {
	    padding: 4px 0px;
	}
	.select_category_overseas input[type=radio]{
	    display: none;
	}
	.select_category_overseas input[type=radio]+label{
	    display: inline-block;
	    cursor: pointer;
	    height: 24px;
	    width: 90px;
	    border: 1px solid #333;
	    line-height: 24px;
	    text-align: center;
	    font-weight:bold;
	    font-size:13px;
	}
	.select_category_overseas input[type=radio]+label{
	    background-color: #fff;
	    color: #333;
	}
	.select_category_overseas input[type=radio]:checked+label{
	    background-color: #333;
	    color: #fff;
	}
	/* radio_category_age  */
	/* radio_category_age  */
	.select_category_age {
	    padding: 4px 0px;
	}
	.select_category_age input[type=radio]{
	    display: none;
	}
	.select_category_age input[type=radio]+label{
	    display: inline-block;
	    cursor: pointer;
	    height: 24px;
	    width: 70px;
	    border: 1px solid #333;
	    line-height: 24px;
	    text-align: center;
	    font-weight:bold;
	    font-size:13px;
	}
	.select_category_age input[type=radio]+label{
	    background-color: #fff;
	    color: #333;
	}
	.select_category_age input[type=radio]:checked+label{
	    background-color: #333;
	    color: #fff;
	}
	/* radio_category_all  */
	/* radio_category_all  */
	.select_category_all {
	    padding: 4px 0px;
	}
	.select_category_all input[type=radio]{
	    display: none;
	}
	.select_category_all input[type=radio]+label{
	    display: inline-block;
	    cursor: pointer;
	    height: 24px;
	    width: 70px;
	    border: 1px solid #333;
	    line-height: 24px;
	    text-align: center;
	    font-weight:bold;
	    font-size:13px;
	}
	.select_category_all input[type=radio]+label{
	    background-color: #fff;
	    color: #333;
	}
	.select_category_all input[type=radio]:checked+label{
	    background-color: #333;
	    color: #fff;
	}
	/* footer  */
	/* footer  */
	footer {
	    background:white;
	    width: 1550px;
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
			<h1 class="first"><span>관리자 재고 (수정/삭제) 상세 page</span></h1>
		</div>
		<header>
			<div class="headermenu">
				<ul>
					<li><a href="insert_form.jsp">☛ 관리자 재고 insert page </a></li>
					<li><a href="회원관리.jsp">☛ 회원관리 page </a></li>
					<li><a href="new_book_shop_from.jsp">☛ 판매 main page </a></li>
				</ul>
			</div>
		</header>
		
<%
	// request.getParameter()
	String param_book_no = request.getParameter("book_no");	
	// String >>> int 변환
	int book_no_int = Integer.parseInt(param_book_no);
	// 데이터베이스에 SQL문을 전달하는 PreparedStatement 객체
	PreparedStatement pstmt = null;
	// 데이터베이스로부터 결과값을 전달받는 ResultSet 객체 
	ResultSet rs = null;
	// JDBCUtil 정보 연결
	Connection conn = JDBCUtil.getConnection();
	
	try {
		// SQL문 작성하고 실행하기
		String sql = " SELECT * FROM books WHERE book_no = '"+ book_no_int +"'";
		// JDBC받은 정보와 함께 SQL문 저장
		pstmt = conn.prepareStatement(sql);
		// executeQuery() 행의 정보를 받는다.
		rs = pstmt.executeQuery();
		// next() 첫행 반복 출력
		while (rs.next()) {	
%>	
        <section>
            <form 
            	action="book_update_check.jsp"   
            	method="POST" 
            	enctype="multipart/form-data"
            >
            <table border="1" class="inserttable">
		        <tr>
		            <td rowspan="18" style="background-color: #dee2e6;">
		            	<img src="img/<%=rs.getString("book_fileName")%>" class="bimg" onerror="this.onerror=null; this.src='img/noimages.png';" />
		            </td>
		        </tr>
                <tr>
                    <td class="inbox_2">title (책 이름)</td>
                    <td class="r_menu"><%=rs.getString("title")%></td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="title" autocomplete="off" value="<%=rs.getString("title")%>" required />
                    </td>
                </tr>
                 <tr>
                    <td class="inbox_2">book_no (제품 고유 넘버)</td>
                    <td class="r_menu"><%=rs.getString("book_no")%></td>
                    <td class="inbox" style="text-align: left;">
		           		<input type="text" class="inbox_1_not" name="book_no" value="<%=rs.getString("book_no")%>" readonly />
		           		<del style="color: red;"><small> 수정불가항목</small></del>            
                    </td>
                </tr>    
                <tr>
                    <td class="inbox_2">book_id (제품 등록 ID) </td>
                    <td class="r_menu"><%=rs.getString("book_id")%></td>
                    <td class="inbox" style="text-align: left;">
		           		<input type="text" class="inbox_1_not" name="book_id" value="<%=rs.getString("book_id")%>" readonly />
		           		<del style="color: red;"><small> 수정불가항목</small></del>            
                    </td>
                </tr>                 
                <tr>
                    <td class="inbox_2">author (저자)</td>
                    <td class="r_menu"><%=rs.getString("author")%></td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="author" autocomplete="off" value="<%=rs.getString("author")%>" />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">publisher (출판사)</td>
                    <td class="r_menu"><%=rs.getString("publisher")%></td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="publisher" autocomplete="off" value="<%=rs.getString("publisher")%>" />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">book_memo (한줄 소개)</td>
                    <td class="r_menu"><%=rs.getString("book_memo")%></td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="book_memo" autocomplete="off" value="<%=rs.getString("book_memo")%>" />
                    </td>
                </tr>                
                <tr>
                    <td class="inbox_2">new_old_ebook (신품/중고/e-book)</td>
                    <td class="r_menu"><%=rs.getString("new_old_ebook")%></td>
                    <td class="inbox">
						<div class="select_new_old_ebook">
						     <input type="radio" id="select_new_old_ebook" name="new_old_ebook" value="new"><label for="select_new_old_ebook">신품</label>
						</div>    
					</td>        
                </tr>
                <tr>
                    <td class="inbox_2">price (제품 가격)</td>
                    <td class="r_menu"><%=rs.getString("price")%> 원</td>
                    <td class="inbox">
                    <!-- price 천단위 변환 -->
                        <input class="inbox_1" id="number" type="text" name="price" autocomplete="off" value="<%=rs.getString("price")%>" />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">stock (입고 수량)</td>
                    <td class="r_menu"><%=rs.getString("stock")%> 개</td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="stock" autocomplete="off" value="<%=rs.getString("stock")%>" />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">category_overseas (국내/외 구분)</td>
                    <td class="r_menu"><%=rs.getString("category_overseas")%></td>
                    <td class="inbox">
						<div class="select_category_overseas">
						     <input type="radio" id="select_category_overseas" name="category_overseas" value="국내도서"><label for="select_category_overseas">국내도서</label>
						     <input type="radio" id="select2_category_overseas" name="category_overseas" value="외국도서"><label for="select2_category_overseas">외국도서</label>
						</div>    
					</td>        
                </tr> 
                <tr>
                    <td class="inbox_2">category_age (연령대 구분)</td>
                    <td class="r_menu"><%=rs.getString("category_age")%></td>
                    <td class="inbox">
						<div class="select_category_age">
						     <input type="radio" id="select_category_age" name="category_age" value="10대"><label for="select_category_age">10대</label>
						     <input type="radio" id="select2_category_age" name="category_age" value="20대"><label for="select2_category_age">20대</label>
						     <input type="radio" id="select3_category_age" name="category_age" value="30대"><label for="select3_category_age">30대</label>
						     <input type="radio" id="select4_category_age" name="category_age" value="40대"><label for="select4_category_age">40대</label>
						     <input type="radio" id="select5_category_age" name="category_age" value="50대+"><label for="select5_category_age">50대+</label>
						</div>    
					</td>     
                </tr>
                <tr>
                    <td class="inbox_2" rowspan="3">category_all (대분류)</td>
                    <td class="r_menu" rowspan="3"><%=rs.getString("category_all")%></td>
                    <td class="inbox">
						<div class="select_category_all">
						     <input type="radio" id="select_category_all" name="category_all" value="인문"><label for="select_category_all">인문</label>
						     <input type="radio" id="select1_category_all" name="category_all" value="역사"><label for="select1_category_all">역사</label>
						     <input type="radio" id="select2_category_all" name="category_all" value="예술"><label for="select2_category_all">예술</label>
						     <input type="radio" id="select3_category_all" name="category_all" value="종교"><label for="select3_category_all">종교</label>
						     <input type="radio" id="select4_category_all" name="category_all" value="사회"><label for="select4_category_all">사회</label>
						     <input type="radio" id="select5_category_all" name="category_all" value="과학"><label for="select5_category_all">과학</label>
						     <input type="radio" id="select6_category_all" name="category_all" value="경제"><label for="select6_category_all">경제</label>	
						     <input type="radio" id="select7_category_all" name="category_all" value="IT"><label for="select7_category_all">IT</label>
						</div>    
					</td>    
                </tr>                
                <tr>
                    <td class="inbox">
						<div class="select_category_all">
						     <input type="radio" id="select8_category_all" name="category_all" value="취미"><label for="select8_category_all">취미</label>
						     <input type="radio" id="select9_category_all" name="category_all" value="요리"><label for="select9_category_all">요리</label>
						     <input type="radio" id="select10_category_all" name="category_all" value="여행"><label for="select10_category_all">여행</label>
						     <input type="radio" id="select11_category_all" name="category_all" value="잡지"><label for="select11_category_all">잡지</label>
						     <input type="radio" id="select12_category_all" name="category_all" value="만화"><label for="select12_category_all">만화</label>
						     <input type="radio" id="select13_category_all" name="category_all" value="육아"><label for="select13_category_all">육아</label>
						     <input type="radio" id="select14_category_all" name="category_all" value="건강"><label for="select14_category_all">건강</label>
						     <input type="radio" id="select15_category_all" name="category_all" value="스포츠"><label for="select15_category_all">스포츠</label>
						</div>    
					</td>    
                </tr>  
                <tr>
                    <td class="inbox">
						<div class="select_category_all">
						     <input type="radio" id="select16_category_all" name="category_all" value="유아교재"><label for="select16_category_all">유아교재</label>
						     <input type="radio" id="select17_category_all" name="category_all" value="초등참고서"><label for="select17_category_all">초등참고서</label>
						     <input type="radio" id="select18_category_all" name="category_all" value="중등참고서"><label for="select18_category_all">중등참고서</label>
						     <input type="radio" id="select19_category_all" name="category_all" value="고등참고서"><label for="select19_category_all">고등참고서</label>
						     <input type="radio" id="select20_category_all" name="category_all" value="외국어"><label for="select20_category_all">외국어</label>
						     <input type="radio" id="select21_category_all" name="category_all" value="자격증"><label for="select21_category_all">자격증</label>
						</div>    
					</td>    
                </tr>   
                <tr>
                    <td class="inbox_2">insert_day (최초 등록한 날짜)</td>
                    <td class="r_menu"><%=rs.getString("insert_day")%></td>
                    <td class="inbox" style="text-align: left;">
		           		<input type="text" class="inbox_1_not"  value="<%=rs.getString("insert_day")%>" readonly />
		           		<del style="color: red;"><small> 수정불가항목</small></del>            
                    </td>
                </tr>   
                <tr>
                    <td class="inbox_2" colspan="2">이미지파일첨부</td>
                    <td class="inbox">
                        <input type="file" name="book_Image" accept="image/*" autocomplete="off" />
                    </td>
                </tr>
		        <tr>
		        	<td colspan="4">
		        		<!-- 수정 -->
		            	<!-- <a href="book_update_sql.jsp"> -->
		            	<input class="custom-btn btn-9" type="submit" value="수정하기" style="margin-left: 480px;"/>
		            	<!-- </a> -->
	                	<!-- 삭제 -->
	                	<a href="book_delete.jsp?book_no=<%=rs.getString("book_no")%>">
	                	<input class="custom-btn btn-9" type="button" value="삭제하기" /></a>
		        	</td>
		        </tr>
            </table>
            </form>
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
        <footer>
            <p>Copyright © 베스킨라빈스31.2 Corp. All Rights Reserved.</p>
            <p>고객센터 0000-0000 (유료) 365일 09:00 ~ 18:00 </p>
        </footer>       
    </div>    
</body>
</html>