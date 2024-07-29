<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="servlet.*, java.sql.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 - BASKINROBBINS 31.2</title>
	<link href="../css/adminPage.css" rel="stylesheet" type="text/css"/>
</head>
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
	<div class="wrapper">
        <div class="upperBox">
                <p>BASKINROBBINS 31.2 회원 관리</p>
        </div>
        <div class="lowerBox">
            <table>
                <!-- 상단 고정 -->
                <thead>
                	<tr>
	                    <th>번호</th>
	                    <th>이름</th>
	                    <th>아이디</th>
	                    <th>이메일</th>
	                    <th>휴대폰 번호</th>
	                    <th>생년월일</th>
	                    <th>주소</th>
	                    <th>성별</th>
	                    <th>포인트</th>
	                    <th>판매자</th>
	                    <th>최근 접속 시간</th>
	                    <th>수정</th>
                    </tr>
                </thead>

                <!-- 고객 데이터 서머리 -->
                <tbody>
                <%
                	Statement stmt = null;
                	PreparedStatement pstmt = null;
                	Connection conn = null;
                	ResultSet rs = null;
                	
                    conn = DBUtil.getConnection();
                	String sql = "SELECT memberNum, memberName, memberId, memberEmail, memberPhone, memberBirth, memberAddr1, memberAddr2, memberAddr3, memberGender, money, memberType, memberVisit FROM member";
                	pstmt = conn.prepareStatement(sql);
                	rs = pstmt.executeQuery(sql);
                	
                	while (rs.next()) {
                		int num = rs.getInt("memberNum");
                		String name = rs.getString("memberName");
                		String id = rs.getString("memberId");
                		String email = rs.getString("memberEmail");
                		String phone = rs.getString("memberPhone");
                		String birth = rs.getString("memberBirth");
                		String addr1 = rs.getString("memberAddr1");
                		String addr2 = rs.getString("memberAddr2");
                		String addr3 = rs.getString("memberAddr3");
                		String addr = addr1 + " " + addr2 + " " + addr3;
                		String gender = rs.getString("memberGender");
                		int money = rs.getInt("money");
                		String type = rs.getString("memberType");
                		Timestamp visit = rs.getTimestamp("memberVisit");
                		
                		if (type.equals("0")) {
                			type = "일반";
                		} else if (type.equals("1")) {
                			type = "판매자";                			
                		} else {
                			type = "관리자";
                		}
                %>
                    <tr id="info">
                        <!-- 회원 번호 -->
                        <td class="ellipsis num"><%= num %></td>

                        <!-- 이름 -->
                        <td class="ellipsis name"><%= name %></td>

                        <!-- 아이디 -->
                        <td class="ellipsis id"><%= id %></td>

                        <!-- 이메일 -->
                        <td class="ellipsis email"><%= email %></td>

                        <!-- 휴대폰 번호 -->
                        <td class="ellipsis phone"><%= phone %></td>

                        <!-- 생년월일 -->
                        <td class="ellipsis birth"><%= birth %></td>

                        <!-- 주소 -->
                        <td class="ellipsis addr"><%= addr %></td>

                        <!-- 성별 -->
                        <td class="ellipsis gender"><%= gender %></td>

                        <!-- 포인트 -->
                        <td class="ellipsis point"><%= money %></td>

                        <!-- 판매자 여부 -->
                        <td class="ellipsis type"><%= type %></td>

                        <!-- 최근 접속 시간 -->
                        <td class="ellipsis visit"><%= visit %></td>

                        <!-- 수정 버튼 -->
                        <td class="ellipsis edit"><a href="myPage_Admin.jsp?memberNum=<%= num %>">수정</a></td>
                    </tr>
                 <% } DBUtil.close(rs, pstmt, conn); %>
                 <!-- 페이징 처리 -->
                 <%
					int pageCount = 10;
					int currentPage = 1;
					String paramPage = request.getParameter("page");
					if (paramPage != null) {
						currentPage = Integer.parseInt(paramPage);
					}
					int startRow = (currentPage - 1) * pageCount;
					
					conn = DBUtil.getConnection();
					
					sql = "SELECT * FROM member ORDER BY memberNum DESC LIMIT ?, ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, pageCount);
					rs = pstmt.executeQuery();
					
					DBUtil.close(rs,pstmt,conn);
				%>
				<%
					// table 에 등록된 전체 행(게시물)의 개수
					sql = "SELECT count(*) FROM member";
					conn = DBUtil.getConnection();
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					// 전체 게시물 개수를 저장할 변수
					int totalCount = 0;
					if (rs.next()) {
						totalCount = rs.getInt(1);
					}
					DBUtil.close(rs, stmt, conn);
					
					int maxPage = (totalCount - 1) / pageCount + 1;		// 최대 페이지
					maxPage = (int)Math.ceil((double)totalCount / pageCount);
					
					int startPage = 0;		// 현재 요청 페이지에서 보여줄 시작 페이지 번호
					int endPage = 0;		// 현재 요청 페이지에서 보여줄 마지막 페이지 번호
					int displayPageNum = 10;	// 한 번에 보여줄 페이지 번호 개수
					
					startPage = (currentPage - 1) / displayPageNum * displayPageNum + 1; // 시작 페이지 
					endPage = startPage + (displayPageNum - 1); // 출력할 마지막 페이지 번호
					
					// endPage 가 maxPage 보다 크면 이동할 수 없는 페이지 번호가 출력
					if (endPage > maxPage) {
						endPage = maxPage;
					}
				%>
				<tr>
					<td id="paging" colspan="12">
						<!-- 사용자가 요청한 출력된 현재 페이지가 1페이지가 아니면 출력 -->
						<%if (currentPage != 1) { %>
							<a href="adminPage.jsp?page=1">[처음]</a>
						<%} %>
						
						<%if (startPage != 1) { %>
							<a href="adminPage.jsp?page=<%= startPage - 1%>">[이전]</a>
						<%} %>
						
						<!-- 이동 가능한 페이지 번호 출력 -->
						<%for (int i = startPage; i <= endPage; i++) { %>
							<a href="adminPage.jsp?page=<%=i%>">[<%= i %>]</a>
						<%} %>
						
						<%if (endPage < maxPage) { %>
							<a href="adminPage.jsp?page=<%= endPage + 1%>">[다음]</a>
						<%} %>
						
						<!-- 마지막 페이지 이동 -->
						<%if (currentPage < maxPage) { %>
							<a href="adminPage.jsp?page=<%= maxPage%>">[마지막]</a>
						<%} %>
					</td>
				</tr>	
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>