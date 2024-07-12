<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- join.jsp -->
<%-- 회원 가입 폼 시작 --%>
<form action="useBeanResult.jsp" method="POST">
	<%-- 폼 데이터 전송 방식 설정: POST, 전송될 페이지: useBeanResult.jsp --%>
	이름 : <input type="text" name="name" required /> <br />
	<%-- 이름 입력 필드 (필수 입력) --%>
	주소 : <input type="text" name="addr" required /> <br />
	<%-- 주소 입력 필드 (필수 입력) --%>
	나이 : <input type="number" name="age" required /> <br />
	<%-- 나이 입력 필드 (필수 입력) --%>
	<input type="submit" value="확인" />
	<%-- 폼 제출 버튼 --%>
</form>
<%-- 회원 가입 폼 끝 --%>