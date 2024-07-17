<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- 페이지 지시자: 자바 코드 사용, HTML 콘텐츠 유형, UTF-8 문자 인코딩 설정 --%>
<%-- sqlUpdate.jsp: 비밀번호 변경을 위한 입력 폼 제공 JSP 파일 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 설정 --%>
<title>Insert title here</title> <%-- 페이지 제목 --%>
</head>
<body>

	<%-- 비밀번호 변경 폼 --%>
	<form action="sqlUpdateSubmit.jsp" method="POST"> <%-- 폼 제출 시 sqlUpdateSubmit.jsp 페이지로 POST 방식으로 전송 --%>
		<input type="hidden" name="num" value="${param.num}"/> <%-- 회원 번호를 숨겨진 필드로 전달 (sqlUpdateSubmit.jsp에서 사용) --%>

		<h2>기존 비밀번호를 입력해 주세요.</h2>
		<input type="password" name="pass"/> <%-- 기존 비밀번호 입력 필드 --%>

		<h3>새로운 비밀번호를 입력해 주세요.</h3>
		password : <input type="password" name="newPass"/> <%-- 새로운 비밀번호 입력 필드 --%>

		<button>확인</button> <%-- 폼 제출 버튼 --%>
	</form>
</body>
</html>
