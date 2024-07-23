<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자셋 UTF-8 설정 --%>
<title>File Upload Download</title> <%-- 페이지 제목 --%>
</head>
<body>
	<h1>part - fileUplad</h1> <%-- 페이지 주요 제목 --%>

	<%-- 파일 업로드 폼 --%>
	<form action="result" method="post" enctype="multipart/form-data"> <%-- 업로드 처리 페이지로 POST 방식 전송, enctype 설정 필수 --%>
		<input type="file" name="file" accept="image/*, .pdf" multiple/> <br/> <%-- 여러 이미지 파일 또는 PDF 파일 업로드 가능 --%>
		<input type="file" name="file1" /> <br/> <%-- 추가 파일 업로드 필드 --%>
		<input type="text" name="test"/> <br/> <%-- 일반 텍스트 입력 필드 (테스트용) --%>
		<button>업로드</button> <%-- 업로드 버튼 --%>
	</form>

	<%--
		enctype 설명:
		- application/x-www-form-urlencoded (기본값): 모든 문자를 URL 인코딩하여 전송 (파일 업로드에는 부적합)
		- multipart/form-data: 각 파트별로 인코딩하여 전송 (파일 업로드에 적합)
	--%>
</body>
</html>
