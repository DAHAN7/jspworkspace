<%@ page language="java" contentType="text/html; charset=UTF-8"%><%-- JSP 페이지 설정: 자바 언어 사용, 문자 인코딩 UTF-8 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- 문자 인코딩 UTF-8 설정 --%>
<title>forwardTest.jsp</title>
<%-- 페이지 제목 설정 --%>
</head>
<body>
	<%-- forwardTest2.jsp 페이지로 데이터 전송을 위한 폼 --%>
	<form action="forwardTest2.jsp" method="POST">
		<%-- forwardTest1.jsp 페이지로 다시 돌아갈 때 사용할 숨겨진 입력 필드 --%>
		<input type="hidden" name="nextPage" value="forwardTest1.jsp" />
		<table>
			<%-- 테이블 행과 열 생성 (주석: tr>td*2)*4는 Emmet 축약 문법) --%>
			<!-- (tr>td*2)*4 -->
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" /></td> <%-- 이름 입력 필드 --%>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type="number" name="age" /></td> <%-- 나이 입력 필드 --%>
			</tr>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="addr" /></td> <%-- 주소 입력 필드 --%>
			</tr>
			<tr>
				<td colspan="2"><%-- 두 열을 합쳐 버튼 배치 --%>
					<button>확인</button><%-- 폼 제출 버튼 --%>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>