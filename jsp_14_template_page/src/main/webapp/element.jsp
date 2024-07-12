<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- JSP 페이지 설정: 자바 언어 사용, 콘텐츠 유형은 HTML, 문자 인코딩은 UTF-8 --%>
<%-- JSP 파일 이름 주석 --%>
<!DOCTYPE html> <%-- HTML5 문서임을 선언 --%>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 UTF-8 설정 (한글 처리) --%>

<title>Custom Tag</title> <%-- 페이지 제목 설정 --%>

<style>
	<%-- 커스텀 태그 "choi" 스타일 지정 --%>
	choi {
		display: block;      <%-- 블록 레벨 요소로 설정 --%>
		padding: 10px;       <%-- 내부 여백 설정 --%>
		background-color: black; <%-- 배경색 설정 --%>
		color: white;         <%-- 글자색 설정 --%>
	}
</style>
</head>
<body>

	<%-- 커스텀 태그 "choi" 사용 예시 (주석 처리됨) --%>
	<%-- <choi id="choiName" class="choiClass"><h1>Choi Class</h1></choi> --%>

	<%-- 커스텀 태그 "choi" 정의 --%>
	<jsp:element name="choi"> <%-- 태그 이름 설정 --%>

	    <%-- id 속성 정의 --%>
		<jsp:attribute name="id"> 
			choiName 
		</jsp:attribute>

		<%-- class 속성 정의 --%>
		<jsp:attribute name="class"> 
			choiClass 
		</jsp:attribute>

		<%-- 커스텀 태그의 내용 (body) --%>
		<jsp:body>
			<h1>Choi Class</h1> 
		</jsp:body>
	</jsp:element>

</body>
</html>
