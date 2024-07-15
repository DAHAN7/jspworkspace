<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%-- JSP 파일 이름 주석 --%>
<!-- jstlSQL.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><%-- 문자 인코딩 UTF-8 설정 --%>
<title>Insert title here</title> <%-- 페이지 제목 (브라우저 탭에 표시) --%>
</head>
<body>
	<form action="sqlResult.jsp" method="POST"> <%-- 폼 데이터를 처리할 JSP 페이지와 전송 방식 설정 --%>
		id : <input type="text" name="id" required/> <br/><%-- 아이디 입력 필드 (필수 입력) --%>
		pass : <input type="password" name="pass" required/> <br/><%-- 비밀번호 입력 필드 (필수 입력, 입력값 마스킹) --%>
		addr : <input type="text" name="addr" required/> <br/><%-- 주소 입력 필드 (필수 입력) --%>
		phone : <input type="text" name="phone" required/> <br/><%-- 전화번호 입력 필드 (필수 입력) --%>
		gender : <label> <%-- 성별 선택 (라디오 버튼) --%>
			<input type="radio" name="gender" value="남성"/> 남성
		</label>
		<label>
			<input type="radio" name="gender" value="여성" checked/> 여성
		</label> <%-- 기본값으로 선택됨 --%>
		<br/>
		age : <input type="number" name="age" min="1"/> <br/><%-- 나이 입력 필드 (숫자 입력, 최소값 1) --%>
		<button>확인</button> <%-- 폼 제출 버튼 --%>
	</form>
</body>
</html>























