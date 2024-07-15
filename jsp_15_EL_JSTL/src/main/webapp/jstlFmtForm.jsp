<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- 페이지 언어, 콘텐츠 유형, 문자 인코딩 설정 --%>
<%-- jstlFmtForm.jsp: 사용자 입력을 받는 폼 JSP 페이지 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 UTF-8 설정 --%>
<title>Insert title here</title>
</head>
<body>

	<form action="jstlFMT.jsp" method="POST"> <%-- 폼 데이터를 처리할 JSP 페이지와 전송 방식 설정 --%>
		<input type="date" name="selectDate" min="2024-07-15" max="2024-08-14" required/><br/> <%-- 날짜 입력 필드 (필수 입력, 최소/최대 날짜 제한) --%>
		<input type="number" name="price" min="0" max="1000000" step="1000"/> <br/> <%-- 가격 입력 필드 (최소값 0, 최대값 1000000, 증가 단위 1000) --%>
		<input type="text" name="addr" /> <br/> <%-- 주소 입력 필드 --%>
		<select name="encode"> <%-- 언어 선택 드롭다운 --%>
			<option value="ko_KR">한국어</option>
			<option value="en_US">English</option>
		</select>
		<br/> 	
		<button>확인</button> <%-- 폼 제출 버튼 --%>
	</form>

</body>
</html>
