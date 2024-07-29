<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
	<link href="../css/join.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<div class="wrapper">
        <form action="">
            <table>
                <!-- 이름 -->
                <tr>
                    <td rowspan="9" style="width: 150px;" class="first">회원 정보<p></td>
                    <td style="width: 150px;">이름</td>
                    <td style="width: 200px;">
                        <input type="text" class="input-box" required autofocus>
                    </td>
                    <td></td>
                </tr>
                <!-- 아이디 -->
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" id="input_box_id" required  minlength="4" maxlength="12">
                        <input type="button" id="idBtn" value="중복 확인">
                        <span>4~12자리의 영문자, 숫자 (/,!@#$ 등 특수문자는 제외) </span>
                    </td>
                    <td></td>
                </tr>
                <!-- 이메일 -->
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="email" id="input_email" required>
                        <span>아이디, 패스워드 찾기</span>
                    </td>
                    <td>
        
                    </td>
                </tr>
                <!-- 비밀번호 -->
                <tr>
                    <td>비밀번호</td>
                    <td>
                        <input type="password" class="input-box" required minlength="10" maxlength="20">
                        <span>영문, 숫자, 특수 문자 중 2가지 이상을 조합하여 10~20자</span>
                    </td>
                    <td></td>
                </tr>
                <!-- 비밀번호 확인 -->
                <tr>
                    <td>비밀번호 재입력</td>
                    <td>
                        <input type="password" class="input-box" required minlength="10" maxlength="20">
                        <span>비밀번호를 다시 한 번 입력해주세요.</span>
                    </td>
                    <td></td>
                </tr>
                <!-- 휴대폰 -->
                <tr>
                    <td>휴대전화</td>
                    <td>
                        <input type="text" class="input-phoneNumber" required maxlength="4"> - 
                        <input type="text" class="input-phoneNumber" required maxlength="4"> - 
                        <input type="text" class="input-phoneNumber" required maxlength="4"> <br />
                        <span>주문 배송 및 ARS 중고 매장 이용 시 본인 확인용</span>
                    </td>
                    <td></td>
                </tr>
                <!-- 주소 -->
                <tr>
                    <td>주소</td>
                    <td class="td_relative">
                    	<!-- 우편 번호 -->
                        <input type="text" id="zipcode" maxlength="5" readonly>
                        <span class="innerZip">우편 번호</span>
                        <!-- 검색 버튼 -->
                        <input type="button" value="우편 번호 검색" id="addrBtn">
                        <!-- 도로명 주소 -->
                        <input type="text" id="road" readonly>
                        <span class="innerRoad">도로명 / 지번</span>
                        <!-- 상세 주소 -->
                        <input type="text" id="detailAddr">
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
                        	<input type="radio" name="gender" value="1" checked="checked">
                        	<span class="radio_span">남자</span>
                        </lable>
                        <label>
                        	<input type="radio" name="gender" value="2">
                        	<span class="radio_span">여자</span>
                        </label>
                    </td>
                    <td></td>
                </tr>
                <!-- 판매자 여부 -->
                <tr>
                    <td>판매자</td>
                    <td class="seller_table">
                    	<label>
                        	<input type="radio" name="seller" value="1">
                        	<span class="radio_span">예</span>
                        </lable>
                        <label>
                        	<input type="radio" name="seller" value="2" checked="checked">
                        	<span class="radio_span">아니오</span>
                        </label>
                        <span class="seller_chk">중고샵 판매자 이용 여부 확인</span>
                    </td>
                    <td></td>
                </tr>
            </table>
            <br />
            <hr />
            <div class="tail">
                <button type="submit" class="btn">회원 정보 수정</button>
            </div>
        </form>
    </div>
    
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="js/addr.js"></script>
</body>
</html>