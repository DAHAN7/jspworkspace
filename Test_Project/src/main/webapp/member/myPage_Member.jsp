<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보수정 - BASKINROBBINS 31.2</title>
	<link href="../css/join.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%
	String userId = (String) session.getAttribute("userId");

		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT memberName, memberId, memberEmail, memberPhone, memberAddr1, memberAddr2, memberAddr3, memberGender, memberType FROM member WHERE memberId = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userId);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			String name = rs.getString("memberName");
			String mId = rs.getString("memberId");
			String email = rs.getString("memberEmail");
			String phone = rs.getString("memberPhone");
			String addr1 = rs.getString("memberAddr1");
			String addr2 = rs.getString("memberAddr2");
			String addr3 = rs.getString("memberAddr3");
			String gender = rs.getString("memberGender");
			int type = rs.getInt("memberType");
%>
	<div class="wrapper">
		<!-- 아이디 중복 체크로 action 뻘한 곳으로 빠짐 -->
        <form id="joinForm" action="updateProfile.jsp" method="POST">
            <table>
                <!-- 이름 -->
                <tr>
                    <td rowspan="7" style="width: 150px;" class="first">개인 정보 변경<p></td>
                    <td style="width: 150px;">이름</td>
                    <td style="width: 200px;">
                    	<!-- 입력값 제한 (한글만) -->
                        <input type="text" class="input_box" name="name" 
                        pattern="[ㄱ-ㅎ가-힣]+" required disabled value="<%= name %>">
                        <span>개명으로 인한 이름 수정은 관리자에게 문의주세요.</span>
                        <input type="hidden" name="name" value="<%= name %>">
                    </td>
                    <td></td>
                </tr>
                
                <!-- 아이디 -->
                <tr>
                    <td>아이디</td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자만) -->
                        <input type="text" id="input_box_id" name="mId" 
                        pattern="^[a-zA-Z0-9]{4,12}$" disabled value="<%= mId %>">
                        <input type="hidden" name="mId" value="<%= mId %>">
                    </td>
                    <td id="idCheckMessage" style="padding-left: 10px"></td>
                </tr>
                
                <!-- 이메일 -->
                <tr>
                    <td>이메일</td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자만) -->
                        <input type="email" id="input_email" name="email"
                        pattern="^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]{2,}$" required value="<%= email %>">
                    </td>
                    <td>
                    </td>
                </tr>
                
                <!-- 휴대폰 -->
                <tr>
                    <td>휴대전화</td>
                    <td>
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_phoneNumber" name="phone" 
                        placeholder="('-'을 빼고 입력하세요.)" pattern="^[0-9]{10,11}$" required value="<%= phone %>"> <br />
                    </td>
                    <td></td>
                </tr>
                
                <!-- 주소 -->
                <tr>
                    <td>주소</td>
                    <td class="td_relative">
                    	<!-- 우편 번호 -->
                        <input type="text" id="zipcode" name="addr1" maxlength="5" readonly value="<%= addr1 %>">
                        <span class="innerZip">우편 번호</span>
                        <!-- 검색 버튼 -->
                        <input type="button" value="우편 번호 검색" id="addrBtn">
                        <!-- 도로명 주소 -->
                        <input type="text" id="road" name="addr2" readonly value="<%= addr2 %>">
                        <span class="innerRoad">도로명 / 지번</span>
                        <!-- 상세 주소 -->
                        <input type="text" id="detailAddr" name="addr3" value="<%= addr3 %>">
                        <span class="innerDetail">상세 주소</span> <br />
                    </td>
                    <td></td>
                </tr>
                
                <!-- 성별 -->
                <tr>
                    <td>성별</td>
                    <td>
                    	<label>
                        	<input type="radio" name="gender" value="남자" <%= "남자".equals(gender) ? "checked" : "" %> disabled>
                        	<span class="radio_span">남자</span>
                        </label>
                        <label>
                        	<input type="radio" name="gender" value="여자" <%= "여자".equals(gender) ? "checked" : "" %> disabled>
                        	<span class="radio_span">여자</span>
                        </label>
                        <input type="hidden" name="gender" value="<%= gender %>">
                    </td>
                    <td></td>
                </tr>
                
                <!-- 판매자 여부 -->
                <tr>
                    <td>판매자</td>
                    <td class="seller_table">
                    	<label>
                        	<input type="radio" name="type" value="0" <%= type == 0 ? "checked" : "" %>>
                        	<span class="radio_span">예</span>
                        </label>
                        <label>
                        	<input type="radio" name="type" value="1" <%= type == 1 ? "checked" : "" %>>
                        	<span class="radio_span">아니오</span>
                        	<!-- 관리자 식별 번호 : 2 -->
                        	<input type="hidden" name="type" value="2">
                        </label>
                        <span class="seller_chk">중고샵 판매자 이용 여부 확인</span>
                    </td>
                    <td></td>
                </tr>
                <%
					}
					DBUtil.close(conn, pstmt, rs);
                %>
            </table>
            <br />
            <hr />
            <div class="tail">
                <button type="submit" class="btn">개인 정보 수정</button>
            </div>
        </form>
    </div>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="../js/addr.js"></script>
</body>
</html>