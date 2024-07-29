<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정 - BASKINROBBINS 31.2</title>
	<style>
        .message {
            margin-top: 10px;
            display: none;
            font-size: 12px; /* 기본 폰트 크기 */
        }
        .id_chk {
            color: green;
        }
        .id_err {
            color: red;
        }
    </style>
	<link href="../css/join.css" rel="stylesheet" type="text/css"/>
	<script>
	function checkId() {
        var mId = document.getElementById("input_box_id").value;
        var idCheckMessage = document.getElementById("idCheckMessage");
        
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "checkID.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.status === "OK") {
                    idCheckMessage.innerText = response.message;
                    idCheckMessage.classList.add("id_chk");
                    idCheckMessage.classList.remove("id_err");
                } else if (response.status === "EXISTS") {
                    idCheckMessage.innerText = response.message;
                    idCheckMessage.classList.add("id_err");
                    idCheckMessage.classList.remove("id_chk");
                } else {
                    idCheckMessage.innerText = response.message;
                    idCheckMessage.classList.add("id_err");
                    idCheckMessage.classList.remove("id_chk");
                }
                idCheckMessage.style.display = "block"; // 메세지 표시
            }
        };
        xhr.send("mId=" + encodeURIComponent(mId));
    }
	</script>
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
	<%
		String Num = request.getParameter("memberNum");
    	int memberNum = Integer.parseInt(Num);
	
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT memberNum, memberName, memberId, memberEmail, memberPassword, memberPhone, memberBirth, memberAddr1, memberAddr2, memberAddr3, memberGender, money, memberJoin, memberVisit, memberType, memberWithdraw FROM member WHERE memberNum = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberNum);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			int num = rs.getInt("memberNum");
			String name = rs.getString("memberName");
			String mId = rs.getString("memberId");
			String email = rs.getString("memberEmail");
			String mPw = rs.getString("memberpassword");
			String phone = rs.getString("memberPhone");
			String birth = rs.getString("memberBirth");
			String addr1 = rs.getString("memberAddr1");
			String addr2 = rs.getString("memberAddr2");
			String addr3 = rs.getString("memberAddr3");
			String gender = rs.getString("memberGender");
			int money = rs.getInt("money");
			Timestamp join = rs.getTimestamp("memberJoin");
			Timestamp visit = rs.getTimestamp("memberVisit");
			int type = rs.getInt("memberType");
			String withdraw = rs.getString("memberWithdraw");
	%>
	<div class="wrapper">
		<!-- 아이디 중복 체크로 action 뻘한 곳으로 빠짐 -->
        <form id="joinForm" action="admin_updateProfile.jsp" method="POST">
            <table>
                <!-- 번호 -->
                <tr>
                    <td rowspan="14" style="width: 150px;" class="first">회원 정보 수정</td>
                    <td style="width: 150px;">회원 번호</td>
                    <td style="width: 200px;">
                    	<!-- 입력값 제한 (한글만) -->
                        <input type="text" class="input_box" name="num" required value="<%= num %>">
                    </td>
                    <td></td>
                </tr>

                <!-- 이름 -->
                <tr>
                    <td style="width: 150px;">이름</td>
                    <td style="width: 200px;">
                    	<!-- 입력값 제한 (한글만) -->
                        <input type="text" class="input_box" name="name" required value="<%= name %>">
                    </td>
                    <td></td>
                </tr>
                
                <!-- 아이디 -->
                <tr>
                    <td>아이디</td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자만) -->
                        <input type="text" id="input_box_id" name="mId" pattern="^[a-zA-Z0-9]{4,12}$" required value="<%= mId %>">
                        <input type="button" id="idBtn" value="중복 확인" onclick="checkId()">
                        <span>4~12자리의 영문자, 숫자 (/,!@#$ 등 특수문자는 제외) </span>
                    </td>
                    <td id="idCheckMessage" class="message" style="padding-left: 10px"></td>
                </tr>
                
                <!-- 이메일 -->
                <tr>
                    <td>이메일</td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자만) -->
                        <input type="email" id="input_email" name="email"
                        pattern="^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]{2,}$" required value="<%= email %>">
                        <span>아이디, 패스워드 찾기</span>
                    </td>
                    <td>
                    </td>
                </tr>
                
                <!-- 비밀번호 -->
                <tr>
                    <td>비밀번호</td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자, 특수 문자) -->
                    	<!-- 문자열 중 2가지 이상의 문자(영문, 숫자, 특문)을 포함하는지 확인 -->
                    	<!-- pattern 속성으로 안먹히면 java script 사용 -->
                        <input type="password" class="input_box" id="mPw" name="mPw"
                        pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])[a-zA-Z0-9!@#\$%\^&\*]{10,20}$" required value="<%= mPw %>">
                        <span>영문, 숫자, 특수 문자 중 2가지 이상을 조합하여 10~20자</span>
                    </td>
                    <td rowspan="2" id="pwCheckMessage" style="padding-left: 10px"></td>
                </tr>
                
                <!-- 휴대폰 -->
                <tr>
                    <td>휴대전화</td>
                    <td>
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_phoneNumber" name="phone" 
                        placeholder="('-'을 빼고 입력하세요.)" pattern="^[0-9]{10,11}$" required value="<%= phone %>"> <br />
                        <span>주문 배송 및 ARS 중고 매장 이용 시 본인 확인용</span>
                    </td>
                    <td></td>
                </tr>
                
                <!-- 생년월일 -->
                <tr>
                    <td>생년월일</td>
                    <td>
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_box" name="birth" 
                        placeholder="(생년월일을 입력해주세요. (EX 20000101)" pattern="^[0-9]{8}$" required value="<%= birth %>"> <br />
                        <span></span>
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
                        <span>주문 배송 시 물품 도착지</span>
                    </td>
                    <td></td>
                </tr>
                
                <!-- 성별 -->
                <tr>
                    <td>성별</td>
                    <td>
                    	<label>
                        	<input type="radio" name="gender" value="남자" <%= "남자".equals(gender) ? "checked" : "" %>>
                        	<span class="radio_span">남자</span>
                        </label>
                        <label>
                        	<input type="radio" name="gender" value="여자" <%= "여자".equals(gender) ? "checked" : "" %>>
                        	<span class="radio_span">여자</span>
                        </label>
                    </td>
                    <td></td>
                </tr>

                <!-- 포인트 -->
                <tr>
                    <td style="width: 150px;">포인트</td>
                    <td style="width: 200px;">
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_box" name="money" 
                        pattern="[0-9]+" required value="<%= money %>">
                    </td>
                    <td></td>
                </tr>

                <!-- 가입일 -->
                <tr>
                    <td style="width: 150px;">가입일</td>
                    <td style="width: 200px;">
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_box" name="join" 
                        readonly required value="<%= join %>">
                    </td>
                    <td></td>
                </tr>

                <!-- 최종 방문일 -->
                <tr>
                    <td style="width: 150px;">최종 방문일</td>
                    <td style="width: 200px;">
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_box" name="visit" 
                        readonly required value="<%= visit %>">
                    </td>
                    <td></td>
                </tr>
                
                <!-- 판매자 여부 -->
                <tr>
                    <td>중고샵 판매자</td>
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
                
                <!-- 회원 탈퇴 여부 -->
                <tr>
                    <td>회원 탈퇴 여부</td>
                    <td>
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" name="withdraw" required value="<%= withdraw %>"> <br />
                    </td>
                    <td></td>
                </tr>
                <% } %>
            </table>
            <br />
            <hr />
            <div class="tail">
                <button type="submit" class="btn">회원 수정</button>
            </div>
        </form>
    </div>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="../js/addr.js"></script>
    
</body>
</html>