<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호변경 - BASKINROBBINS 31.2</title>
<link href="${pageContext.request.contextPath}/css/changePW.css" rel="stylesheet" type="text/css"/>
<script>
	// 새로 입력 버튼
	function clearForm() {
		document.getElementById("pw1").value = "";
		document.getElementById("pw2").value = "";
		document.getElementById("pw3").value = "";
		document.getElementById("pwMessage").innerText = "영문/숫자/특수문자를 조합하여 10~16자로 입력해주세요.";
        document.getElementById("pwCheckMessage").innerText = "비밀번호를 다시 한 번 입력해주세요.";
        document.getElementById("pwMessage").style.color = ""; 		// Reset color
        document.getElementById("pwCheckMessage").style.color = ""; // Reset color
	}
</script>
</head>
<body>
	<div>
        <nav>
            <ul>
            	<li class="title"><p>내정보관리</p></li>
                <li><a href="check_before_myPage.jsp">개인정보변경</a></li>
                <li><a href="changePW.jsp">비밀번호변경</a></li>
                <li><a href="check_before_secede.jsp">회원탈퇴</a></li>
            </ul>
        </nav>
    </div>
	<form action="${pageContext.request.contextPath}/ChangePwServlet" method="POST">
		<div id=wrapper>
			<div id="upperbox">
                <p>비밀번호변경</p>
                <span>비밀번호는 주기적으로 변경해주시기 바랍니다.</span>
			</div>
            <table style="width: 100%">
                <colgroup>
                    <col style="width: 30%">
                    <col style="width: 70%">
                </colgroup>
                <tr style="height: 70px;" id="first">
                    <td>현재 비밀번호</td>
                    <td>
                        <input type="password" name="current" id="pw1" required>
                    </td>
                </tr>
                <tr style="height: 100px;" id="second">
                    <td>새 비밀번호</td>
                    <td>
                        <input type="password" name="newPw" id="pw2" onkeyup="checkPw()" required>
                        <p id="pwMessage">영문/숫자/특수문자를 조합하여 10~16자로 입력해주세요.</p>
                    </td>
                </tr>
                <tr style="height: 100px;" id="third">
                    <td>새 비밀번호 확인</td>
                    <td>
                        <input type="password" name="newPwChk" id="pw3" onkeyup="checkPwMatch()" required>
                        <p id="pwCheckMessage">비밀번호를 다시 한 번 입력해주세요.</p>
                    </td>
                </tr>
            </table>
            <div id="btnbox">
                <input type="submit" id="check" value="확인">
                <input type="button" id="remove" value="새로 입력" onclick="clearForm()">
            </div>
            <div id="lowerbox">
                <p id="notice">안전하게 비밀번호를 관리하는 법!</p>
                <p>1. 이용하시는 사이트들의 아이디/비밀번호를 가급적 다르게 설정해주세요.</p>
                <p>2. 최소 3개월에 한번씩 주기적으로 비밀번호를 변경한다면 해킹의 위험을 줄일 수 있어요.</p>
                <p>3. 친구 또는 주변 사람들과 아이디 및 비밀번호를 함께 사용하면 안돼요.</p>
            </div>
        </div>
	</form>
	<script>
		function checkPw() {
			var current = document.getElementById("pw1").value;
			var newPw = document.getElementById("pw2").value;
			var message = document.getElementById("pwMessage");
			
			// 비밀번호 제한 조건
			var length = /^.{10,16}$/;
			var criteria = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@$!%*?&]).{10,16}$/;
			
			if (!length.test(newPw)) {
				message.innerText = "비밀번호는 10~16자까지 입력 가능합니다.";
				message.style.color = "#F58";
			} else if (!criteria.test(newPw)) {
				message.innerText = "영문/숫자/특수 문자 중 2가지 이상 조합하셔야 합니다.";
	            message.style.color = "#F58";
			} else if (newPw == current) {
				message.innerText = "현재 사용 중인 비밀번호로 변경할 수 없습니다.";
	            message.style.color = "#F58";
			} else {
				message.innerText = "사용 가능한 비밀번호 입니다.";
	            message.style.color = "skyblue";
			}
			
		}
		
		function checkPwMatch() {
			var newPw = document.getElementById("pw2").value;
			var newPwChk = document.getElementById("pw3").value;
			var message = document.getElementById("pwCheckMessage");
			
			if (newPw == newPwChk) {
				message.innerText = "입력한 비밀번호가 일치합니다.";
				message.style.color = "skyblue";
			} else {
				message.innerText = "입력한 비밀번호가 서로 일치하지 않습니다.";
				message.style.color = "#F58";
			}
		}
		
		window.onload = function() {
			document.getElementById("pw2").addEventListener("input", checkPw);
			document.getElementById("pw3").addEventListener("input", checkPwMatch);
		}
	</script>
</body>
</html>