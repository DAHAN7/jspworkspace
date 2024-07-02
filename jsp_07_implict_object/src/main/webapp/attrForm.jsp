<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>attrForm.jsp</title>
</head>
<body>
<!-- attrForm.jsp - 속성 영역 객체 테스트를 위한 입력 폼 -->
<!-- form 요소:사용자가 데이터를 입력하여 attrTest1.jsp로 전송 -->
	<form action="attrTest1.jsp" method="POST">
	<!-- 텍스트 입력 필드:사용자가 ID를 입력할 수 있음 -->
		id : <input type="text" name="id" />
		<!--  폼제출 버튼:사용자가 입력한 데이터를 attrTest1.jsp로 전송 --> 
		<button>확인</button>
	</form>
</body>
</html>