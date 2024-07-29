<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.JDBCUtil, servlet.*, javax.sql.*, javax.naming.*"%>
<!DOCTYPE html>
<html lang="en">
<%
	Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(Cookie c : cookies){
				if(c.getName().equals("memberId")){
					String memberId = c.getValue();
					
					InitialContext init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MySQLDB");
					Connection conn = ds.getConnection();
					PreparedStatement pstmt = conn.prepareStatement(
						"SELECT * FROM member WHERE memberId = ?"
					);
					pstmt.setString(1, memberId);
					
					ResultSet rs = pstmt.executeQuery();
					if(rs.next()){
						MemberVO member = new MemberVO();
						member.setMemberNum(rs.getInt("memberNum"));
						member.setId(rs.getString("memberId"));
						member.setEmail(rs.getString("memberEmail"));
						member.setPassword(rs.getString("memberPassword"));
						member.setPhone(rs.getString("memberPhone"));
						member.setBirth(rs.getString("memberBirth"));
						member.setAddr1(rs.getString("memberAddr1"));
						member.setAddr2(rs.getString("memberAddr2"));
						member.setAddr3(rs.getString("memberAddr3"));
						member.setGender(rs.getString("memberGender"));
						member.setMoney(rs.getInt("Money"));
						member.setJoinDate(rs.getTimestamp("memberJoin"));
						member.setVisitDate(rs.getTimestamp("memberVisit"));
						member.setType(rs.getInt("memberType"));
						member.setWithdraw(rs.getString("memberWithdraw"));
						// session 에 추가
						session.setAttribute("member", member);
					}
				} // check u_id cookie
			} // end for cookies
		}
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매 main page </title>
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
            border: 1px solid gainsboro;
            width: 230px;
            height: 480px;
            margin: 2px 10px 10px 2px;
        }
        .bimg {
            width: 200px;
            height: 290px;
            display: block;
            margin: auto;
            padding-top: 10px;
            border-radius:5%;
        }
        .btitle {
            padding-left: 15px;
            padding-top: 15px;
            font-size: 1.2rem;
            font-weight:600;
            text-decoration-line: none;
        }
        .bauthor {
            padding-left: 15px;
            padding-top: 5px;
            font-size: 0.9rem;
        }
        .bpublisher {
            padding-left: 15px;
            font-size: 0.9rem;
        }
        .bprice {
            padding-left: 15px;
            padding-top: 5px;
            font-size: 1.1rem;
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
        #login{
        	text-align: right;
        	padding-right: 50px;
        }
        #h{
        	display: inline;
        }

</style>
</head>
<body>
<div id="login">
	
	<%
		String userID = (String) session.getAttribute("userId");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection conn = JDBCUtil.getConnection();
		try{
			String sql = "select * from member WHERE memberId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				int memberNum = rs.getInt("memberNum");
				session.setAttribute("memberNum", memberNum);
			}

		} catch (Exception e) {
        e.printStackTrace();
    	} finally {
        	if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        	if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        	if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    	}
	
	%>
	<!-- 위애는 수빈  -->
	
    <% 
	    String userId = (String) session.getAttribute("userId");
	    if (userId != null) { 
	        MemberDAO memberDAO = new MemberDAO();
	        MemberVO member = memberDAO.getMember(userId); // 회원 정보를 가져옵니다.
	        int type = member.getType(); // 회원 유형을 가져옵니다.
    %>
	        <p id ="h">환영합니다, <%= userId %> 님</p>
	        <% 
			System.out.println(member); 
			%>
	        <a href="${pageContext.request.contextPath}/LogoutServlet" id="l">로그아웃</a>
	        <% if (2 == type) { %>
	        	<!-- 관리자일 경우 -->
	            	<a href="admin/admin.jsp">관리자 대시보드</a>
		    <% } else { %> 
		            <br/>
		            <a href="member/check_before_myPage.jsp?user=<%= userId %>">MY PAGE </a> <a href="buy/cart.jsp">장바구니</a>
		            <a href="member/changePW.jsp?user=<%= userId %>">비밀번호 변경</a>
		            <a href="member/check_before_secede.jsp?user=<%= userId %>">회원 탈퇴</a>
		            
		    <% } %>
    <% } else { %>
        <a href="member/login.jsp">로그인</a> <a href="member/join.jsp">회원가입</a> <br />
    
    <% } %>
</div>
    <div class="wrap">
        <ul class="mlogo">
            <a href="index.jsp"><img class="logo" src="img/31.png" title="31"/></a>
            <a href="index.jsp"><div class="logotext">BASKIN ROBBINS 31.2 bookshop</div></a>
            <a href="index.jsp"><img class="logo" src="img/31.png" title="31"/></a>
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
                    	<a href="requestBook/bookBod.jsp">도서신청</a>
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
        <section id="section">
        <!-- SQL 사용해 DB에서 상품 정보 가져오기 -->
	    		<%
	    			
	                // 데이터베이스에 SQL문을 전달하는 PreparedStatement 객체
	    			pstmt = null;
	                // 데이터베이스로부터 결과값을 전달받는 ResultSet 객체 
	    			rs = null;
	                // SQL문 작성하고 실행하기
	    			String sql = "select * from books";
	    			conn = JDBCUtil.getConnection();
	    			pstmt = conn.prepareStatement(sql);
	    			rs = pstmt.executeQuery();
	    			
	                // 실행한 결과값 rs(product 테이블의 모든 레코드) 하나씩 출력
	    			while (rs.next()) {
	    		%>
            <div class="book">
                <a href="new_book_shop_in_from.jsp?book_no=<%=rs.getString("book_no")%>">
                	<img name="12" class="bimg" src="img/<%=rs.getString("book_fileName")%>" 
                	title="<%=rs.getString("title")%>"
                	onerror="this.onerror=null; this.src='img/noimages.png';"/>
                </a>
                <a href="new_book_shop_in_from.jsp?book_no=<%=rs.getString("book_no")%>">
                	<div class="btitle"><%=rs.getString("title")%></div>
                </a>
                <a href="new_book_shop_in_from.jsp?book_no=<%=rs.getString("book_no")%>">
                	<div class="bauthor"><%=rs.getString("author")%></div>
                </a>
                <a href="new_book_shop_in_from.jsp?book_no=<%=rs.getString("book_no")%>">
                	<div class="bpublisher"><%=rs.getString("publisher")%></div>
                </a>
                <a href="new_book_shop_in_from.jsp?book_no=<%=rs.getString("book_no")%>">
                	<div class="bprice"><%=rs.getString("price")%> 원</div>
                </a>
                <a href="new_book_shop_in_from.jsp?book_no=<%=rs.getString("book_no")%>">
                	<div class="bstarscore">9.6점(174건)</div>
                </a>
                <a href="new_book_shop_in_from.jsp?book_no=<%=rs.getString("book_no")%>">
                	<img class="star12345" src="img/star4.png"/>
                </a>
            </div>
            	<%
	    			}
	    		%>
        </section>
        <footer>
            <p>Copyright © 베스킨라빈스31.2 Corp. All Rights Reserved.</p>
            <p>고객센터 0000-0000 (유료) 365일 09:00 ~ 18:00 </p>
        </footer>        
    </div>
</body>
</html>








