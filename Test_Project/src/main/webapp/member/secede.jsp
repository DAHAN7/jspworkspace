<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 - BASKINROBBINS 31.2</title>
<link href="../css/check.css" rel="stylesheet" type="text/css"/>
<script>
	function secedeChk() {
		var input = document.querySelector('input[name="secedeChk"]').value;
	    var button = document.querySelector('input[type="button"]');
	    var correctValue = document.getElementById("secede").innerText;
	    
	    if (input == correctValue) {
	    	button.disabled = false;
	    } else {
	    	button.disabled = true;
	    }
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
	<form action="${pageContext.request.contextPath}/SecedeServlet" method="POST">
		<div id=wrapper>
			<div id="upperbox">
                <p>회원탈퇴</p>
                <span>탈퇴시에 주의사항을 꼭! 확인해주시기 바랍니다.</span>
			</div>
            <hr />
            <div id="lowerbox">
                <div id="innerbox1">
                    <p>회원 탈퇴를 진행하기 위해서 아래의 글자를 정확하게 입력해주세요.</p>
                    <p><span id="secede">회원탈퇴</span>를 입력해주세요.</p>
                </div>
                <div id="innerbox2">
                    <input type="text" name="secedeChk" required>
                    <input type="submit" value="확인">
                </div>
            </div>
		</div>
	</form>
</body>
</html>