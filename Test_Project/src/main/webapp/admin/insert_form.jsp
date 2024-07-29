<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고등록 page</title>
</head>
<body>
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
		padding-left: 180px;
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
	    width: 940px;
	    height: 700px;
	    font-size: 1.0rem;
	    margin-left: 180px;
	    margin-top: 10px;
	    margin-bottom: 30px;
	}
	.inbox {
	    width: 610px;
	    height: 40px;
	    text-align: center;
	}
	.inbox_1 {
	    width: 620px;
	    height: 33px;
	    font-size: 1.1rem;
	}
	.inbox_2 {
		width: 270px;
		height: 30px;
	    padding-left: 15px;
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
			<h1 class="first"><span>관리자 재고 insert page</span></h1>
		</div>
		<header>
			<div class="headermenu">
				<ul>
					<li><a href="list_update_delete.jsp">☛ 관리자 재고 (수정/삭제) list page </a></li>
					<li><a href="회원관리.jsp">☛ 회원관리 page </a></li>
					<li><a href="../index.jsp">☛ 판매 main page </a></li>
				</ul>
			</div>
		</header>
        <section>
            <form 
            	action="insert_check.jsp"  
            	method="POST" 
            	enctype="multipart/form-data"
            >
            <table border="1" class="inserttable">
                <tr>
                    <td class="inbox_2">book_id (제품 등록 ID)</td>
                    <td class="inbox_c">
                        <input class="checkId_1" type="text" name="book_id" id="book_id" autocomplete="off" placeholder="중복 확인 필수.." required />
                    	<button type="button" onclick="fn_dbCheckId()" name="dbCheckId" class="checkId" >
                    		중복 확인
                    	</button>
                    	<!-- 검증 결과를 출력할 박스모델 -->
						<div class="result"></div>
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">title (책 이름)</td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="title" autocomplete="off" required />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">author (저자)</td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="author" autocomplete="off" required />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">publisher (출판사)</td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="publisher" autocomplete="off" required />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">book_memo (한줄 소개)</td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="book_memo" autocomplete="off" required />
                    </td>
                </tr>                
                <tr>
                    <td class="inbox_2">new_old_ebook (신품/중고/e-book)</td>
                    <td class="inbox">
						<div class="select_new_old_ebook">
						     <input type="radio" id="select_new_old_ebook" name="new_old_ebook" value="new" required><label for="select_new_old_ebook">신책</label>
						</div>    
					</td>        
                </tr>
                <tr>
                    <td class="inbox_2">price (제품 가격)</td>
                    <td class="inbox">
                    <!-- price 천단위 변환 -->
                        <input class="inbox_1" id="number" type="text" name="price" autocomplete="off" required />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">stock (입고 수량)</td>
                    <td class="inbox">
                        <input class="inbox_1" type="text" name="stock" autocomplete="off" required />
                    </td>
                </tr>
                <tr>
                    <td class="inbox_2">category_overseas (국내/외 구분)</td>
                    <td class="inbox">
						<div class="select_category_overseas">
						     <input type="radio" id="select_category_overseas" name="category_overseas" value="국내도서" required><label for="select_category_overseas">국내도서</label>
						     <input type="radio" id="select2_category_overseas" name="category_overseas" value="외국도서"><label for="select2_category_overseas">외국도서</label>
						</div>    
					</td>        
                </tr> 
                <tr>
                    <td class="inbox_2">category_age (연령대 구분)</td>
                    <td class="inbox">
						<div class="select_category_age">
						     <input type="radio" id="select_category_age" name="category_age" value="10대" required><label for="select_category_age">10대</label>
						     <input type="radio" id="select2_category_age" name="category_age" value="20대"><label for="select2_category_age">20대</label>
						     <input type="radio" id="select3_category_age" name="category_age" value="30대"><label for="select3_category_age">30대</label>
						     <input type="radio" id="select4_category_age" name="category_age" value="40대"><label for="select4_category_age">40대</label>
						     <input type="radio" id="select5_category_age" name="category_age" value="50대+"><label for="select5_category_age">50대+</label>
						</div>    
					</td>     
                </tr>
                <tr>
                    <td class="inbox_2" rowspan="3">category_all (대분류)</td>
                    <td class="inbox">
						<div class="select_category_all">
						     <input type="radio" id="select_category_all" name="category_all" value="인문" required><label for="select_category_all">인문</label>
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
                    <td class="inbox_2">이미지파일첨부</td>
                    <td class="inbox">
                       	<input type="file" name="book_Image" accept="image/*" />
                    </td>
                </tr>
                <tr>
                    <th colspan="2">
                        <div><center><button class="custom-btn btn-9">등 록</button></center></div>
                    </th>
                </tr>
            </table>
            </form>
        </section>
        <footer>
            <p>Copyright © 베스킨라빈스31.2 Corp. All Rights Reserved.</p>
            <p>고객센터 0000-0000 (유료) 365일 09:00 ~ 18:00 </p>
        </footer>       
    </div>    
</body>
</html>
<script>
	//u_id 검증 완료 여부를 저장할 변수
	var boolUid = false;
	// 정규 표현식으로 동일한 페턴의 id (앞3자리는 국자표시 ex.. kor, usa, cha 등등) + (뒤5자리는 숫자 5자리)
	var regexBookId =/^([a-zA-Z]{3})-([0-9]{5})$/;
	
	document.querySelector("#book_id").onkeyup = function(){
		let tempVal = this.value;
		console.log(tempVal);
		let elP = this.parentNode.querySelector('.result');
		// 정규 표현식과 동일한 패턴의 문자열이면 true, 아니면 false
		if(regexBookId.test(tempVal)){
			elP.innerHTML = "<span style='color:green'>올바른 id 형식입니다.</span>";
		}else{
			elP.innerHTML = "<span style='color:red'>ex) kor-00123 , usa-00123 </span>";
		}
	}; // 중복id 체크 정규표현 span 태그 호출 종료
	
	function fn_dbCheckId(){
		if(document.querySelector("#book_id").value==""){
			alert("입력값이 비었습니다. 북id를 입력해주세요.");
		}else{
			let tempVal = document.querySelector("#book_id").value;
			location.href="check_book_id.jsp?book_id="+tempVal;
		}
	}; // 중복id 체크버튼 function
	
	// price int 입력시 천단위 콤마 
/* 	const input = document.querySelector('#number');
	input.addEventListener('keyup', function(e) {
	  let value = e.target.value;
	  value = Number(value.replaceAll(',', ''));
	  if(isNaN(value)) {
	    input.value = 0;
	  }else {
	    const formatValue = value.toLocaleString('ko-KR');
	    input.value = formatValue;
	  }
	}) 
*/	
</script>











