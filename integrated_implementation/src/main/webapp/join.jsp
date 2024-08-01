<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script>
        function validateForm() {
            var form = document.forms["joinForm"];
            var id = form["id"].value.trim();
            var pass = form["pass"].value.trim();
            var name = form["name"].value.trim();
            var addr = form["addr"].value.trim();
            var phone = form["phone"].value.trim();

            if (!id || !pass || !name || !addr || !phone) {
                alert("모든 필드를 입력하세요.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>
    <main>
        <h1>회원가입</h1>
        <c:choose>
            <c:when test="${empty sessionScope.member}">
                <form name="joinForm" action="join" method="post" onsubmit="return validateForm()">
                    <table class="join">
                        <tr>
                            <th colspan="2"><h2>회원가입</h2></th>
                        </tr>
                        <tr>
                            <td>아이디</td>
                            <td><input type="text" name="id" alt="아이디" required/></td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="pass" alt="비밀번호" required/></td>
                        </tr>
                        <tr>
                            <td>이름</td>
                            <td><input type="text" name="name" alt="이름" required/></td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td><input type="text" name="addr" alt="주소" required/></td>
                        </tr>
                        <tr>
                            <td>전화번호</td>
                            <td><input type="text" name="phone" alt="전화번호" required/></td>
                        </tr>
                        <tr>
                            <td colspan="2"><input type="submit" value="회원가입" /></td>
                        </tr>
                    </table>
                </form>
            </c:when>
            <c:otherwise>
                <p>이미 로그인된 상태입니다. <a href="main.jsp">홈으로 돌아가기</a></p>
            </c:otherwise>
        </c:choose>
    </main>
    <footer>
        <p>Footer content here</p>
    </footer>
</body>
</html>
