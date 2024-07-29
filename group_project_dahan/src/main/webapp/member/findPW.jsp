<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
	<link href="../css/find.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<form action="">
        <div class="wrapper">
            <div class="sign">
                <a href="findID.jsp">아이디 찾기</a>
                <a href="findPW.jsp" class="current" style="color: black;">비밀번호 찾기</a>
            </div>
            <div class="innerWrapper">
                <p>비밀번호 찾기 방법을 선택해 주세요.</p>
                <p>선택하신 수단으로 비밀번호 재설정이 진행됩니다.</p>
                <!-- 휴대폰 번호로 찾기 -->
                <div class="phone" onclick="drop()">등록된 휴대폰 번호로 찾기</div>
                <div class="input_info">
                    <input type="text" class="name" placeholder="이름" required>
                    <input type="text" class="phoneNum" placeholder="휴대폰 번호 ('-'없이 입력)" required minlength="10" maxlength="11">
                    <input type="button" class="send" value="인증번호 발송" required>
                    <input type="text" class="number" placeholder="인증번호 (6자리)" required>
                    <button type="submit" class="btn">확인</button>
                </div>
                
                <!-- 이메일로 찾기 -->
                <div class="email" onclick="drop()">등록된 이메일 주소로 찾기</div>
                <div class="input_info">
                    <input type="text" class="name" placeholder="이름" required>
                    <input type="email" class="emailAddr" placeholder="이메일 주소" required>
                    <input type="button" class="send" value="인증번호 발송" required>
                    <input type="text" class="number" placeholder="인증번호 (6자리)" required>
                    <button type="submit" class="btn">확인</button>
                </div>
            </div>
        </div>
    </form>
    <footer>
        <div>
            <p>Copyright &copy; <span>BASKINROBBINS 31.2</span> All Rights Reserved.</p>
        </div>
    </footer>
    
    <script src="js/drop.js"></script>
</body>
</html>