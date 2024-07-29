<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="servlet.JoinServlet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - BASKINROBBINS 31.2</title>
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
	
		function pwCheck() {
		    var mPw = document.getElementById("mPw").value;
		    var mPwCheck = document.getElementById("mPwCheck").value;
		    var messageElement = document.getElementById("pwCheckMessage");
		
		    if (mPw == mPwCheck) {
		        messageElement.innerText = "비밀번호가 일치합니다.";
		        messageElement.classList.add("pw_chk");
		        messageElement.classList.remove("pw_err");
		    } else {
		        messageElement.innerText = "비밀번호가 일치하지 않습니다.";
		        messageElement.classList.add("pw_err");
		        messageElement.classList.remove("pw_chk");
		    }
		    messageElement.style.display = "block"; // 메세지 표시
		}
	</script>
</head>
<body>
	<div class="wrapper">
		<!-- 아이디 중복 체크로 action 뻘한 곳으로 빠짐 -->
        <form id="joinForm" action="${pageContext.request.contextPath}/JoinServlet" method="POST">
            <table>
                <!-- 이름 -->
                <tr>
                    <td rowspan="10" style="width: 150px;" class="first">기본 정보 입력<p><span class="star">* </span>필수 입력 항목</p></td>
                    <td style="width: 150px;">이름<span class="star"> *</span></td>
                    <td style="width: 200px;">
                    	<!-- 입력값 제한 (한글만) -->
                        <input type="text" class="input_box" name="name" 
                        pattern="[ㄱ-ㅎ가-힣]+" required autofocus>
                    </td>
                    <td></td>
                </tr>
                
                <!-- 아이디 -->
                <tr>
                    <td>아이디<span class="star"> *</span></td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자만) -->
                        <input type="text" id="input_box_id" name="mId" 
                        pattern="^[a-zA-Z0-9]{4,12}$" required>
                        <input type="button" id="idBtn" value="중복 확인" onclick="checkId()">
                        <span>4~12자리의 영문자, 숫자 (/,!@#$ 등 특수문자는 제외) </span>
                    </td>
                    <td id="idCheckMessage" class="message" style="padding-left: 10px"></td>
                </tr>
                
                <!-- 이메일 -->
                <tr>
                    <td>이메일<span class="star"> *</span></td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자만) -->
                        <input type="email" id="input_email" name="email"
                        pattern="^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]{2,}$" required>
                        <span>아이디, 패스워드 찾기</span>
                    </td>
                    <td>
                    </td>
                </tr>
                
                <!-- 비밀번호 -->
                <tr>
                    <td>비밀번호<span class="star"> *</span></td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자, 특수 문자) -->
                    	<!-- 문자열 중 2가지 이상의 문자(영문, 숫자, 특문)을 포함하는지 확인 -->
                    	<!-- pattern 속성으로 안먹히면 java script 사용 -->
                        <input type="password" class="input_box" id="mPw" name="mPw"
                        pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])[a-zA-Z0-9!@#\$%\^&\*]{10,20}$" required>
                        <span>영문, 숫자, 특수 문자 중 2가지 이상을 조합하여 10~20자</span>
                    </td>
                    <td rowspan="2" id="pwCheckMessage" style="padding-left: 10px"></td>
                </tr>
                
                <!-- 비밀번호 확인 -->
                <tr>
                    <td>비밀번호 재입력<span class="star"> *</span></td>
                    <td>
                    	<!-- 입력값 제한 (영문자, 숫자, 특수 문자) -->
                    	<!-- 문자열 중 2가지 이상의 문자(영문, 숫자, 특문)을 포함하는지 확인 -->
                    	<!-- pattern 속성으로 안먹히면 java script 사용 -->
                        <input type="password" class="input_box" id="mPwCheck"
                        pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])[a-zA-Z0-9!@#\$%\^&\*]{10,20}$" onkeyup="pwCheck();" required>
                        <span>비밀번호를 다시 한 번 입력해주세요.</span>
                    </td>
                </tr>
                
                <!-- 휴대폰 -->
                <tr>
                    <td>휴대전화<span class="star"> *</span></td>
                    <td>
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_phoneNumber" name="phone" 
                        placeholder="('-'을 빼고 입력하세요.)" pattern="^[0-9]{10,11}$" required> <br />
                        <span>주문 배송 및 ARS 중고 매장 이용 시 본인 확인용</span>
                    </td>
                    <td></td>
                </tr>
                
                <!-- 생년월일 -->
                <tr>
                    <td>생년월일<span class="star"> *</span></td>
                    <td>
                    	<!-- 입력값 제한 (숫자만) -->
                        <input type="text" class="input_box" name="birth" 
                        placeholder="(생년월일을 입력해주세요. (EX 20000101)" pattern="^[0-9]{8}$" required> <br />
                        <span></span>
                    </td>
                    <td></td>
                </tr>
                
                <!-- 주소 -->
                <tr>
                    <td>주소<span class="star"> *</span></td>
                    <td class="td_relative">
                    	<!-- 우편 번호 -->
                        <input type="text" id="zipcode" name="addr1" maxlength="5" readonly>
                        <span class="innerZip">우편 번호</span>
                        <!-- 검색 버튼 -->
                        <input type="button" value="우편 번호 검색" id="addrBtn">
                        <!-- 도로명 주소 -->
                        <input type="text" id="road" name="addr2" readonly>
                        <span class="innerRoad">도로명 / 지번</span>
                        <!-- 상세 주소 -->
                        <input type="text" id="detailAddr" name="addr3">
                        <span class="innerDetail">상세 주소</span> <br />
                        <span>주문 배송 시 물품 도착지</span>
                    </td>
                    <td></td>
                </tr>
                
                <!-- 성별 -->
                <tr>
                    <td>성별<span class="star"> *</span></td>
                    <td>
                    	<label>
                        	<input type="radio" name="gender" value="남자" checked="checked">
                        	<span class="radio_span">남자</span>
                        </label>
                        <label>
                        	<input type="radio" name="gender" value="여자">
                        	<span class="radio_span">여자</span>
                        </label>
                    </td>
                    <td></td>
                </tr>
                
                <!-- 판매자 여부 -->
                <tr>
                    <td>판매자<span class="star"> *</span></td>
                    <td class="seller_table">
                    	<label>
                        	<input type="radio" name="type" value="0">
                        	<span class="radio_span">예</span>
                        </label>
                        <label>
                        	<input type="radio" name="type" value="1" checked="checked">
                        	<span class="radio_span">아니오</span>
                        	<!-- 관리자 식별 번호 : 2 -->
                        	<input type="hidden" name="type" value="2">
                        </label>
                        <span class="seller_chk">중고샵 판매자 이용 여부 확인</span>
                    </td>
                    <td></td>
                </tr>
            </table>
            <br />
            <hr />
            <div class="tail">
                <button type="submit" class="btn">회원 가입하기</button>
            </div>
        </form>
    </div>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="../js/addr.js"></script>
    
</body>
</html>