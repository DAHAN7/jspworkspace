<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="../css/login.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'>
</head>
<body>
<!-- 로그인 페이지 -->
    <div class="wrapper">
        <form action="">
            <h1>BASKINROBBINS 31.2</h1>
            <!-- 아이디 -->
            <div class="input-box">
                <input type="text" placeholder="아이디" required>
                <i class='bx bxs-user'></i>
            </div>

            <!-- 비밀번호 -->
            <div class="input-box">
                <input type="password" placeholder="비밀번호" required>
                <i class='bx bxs-lock-alt' ></i>
            </div>

            <!-- 아이디 저장 -->
            <div class="remember">
                <label><input type="checkbox"> 아이디 저장</label>
            </div>

            <!-- 로그인 버튼 -->
            <button type="submit" id="btn">로그인</button>

            <!-- 가입, 계정 찾기 -->
            <div class="find">
                <a href="findID.jsp">아이디 찾기</a> |
                <a href="findPW.jsp">비밀번호 찾기</a> |
                <a href="join.jsp">회원가입</a>
            </div>

            <!-- 소셜 로그인 : API 필요해서 더 이상 못 건듦 -->
            <div class="social">
                <ul>
                    <li>
                        <a href="#"><img src="../images/btnG.png" alt="네이버" class="naver"></a>
                    </li>
                    <li>
                        <a href="#" class="kakao"></a>
                    </li>
                    <li>
                        <a href="#" class="google"></a>
                    </li>
                </ul>
            </div>
        </form>
    </div>
</body>
</html>