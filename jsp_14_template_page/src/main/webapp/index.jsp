<%@ page import="test.UserVO"%> <%-- UserVO 클래스 import --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- JSP 페이지 설정: 자바, HTML, UTF-8 인코딩 --%>
<%-- 페이지 이름 주석 --%>
<%
	// 페이지 파라미터 "page" 값 가져오기, 없으면 "default"로 설정
	String includePage = request.getParameter("page");
	if(includePage == null){
		includePage = "default";
	}
	// includePage 변수에 ".jsp" 확장자 추가
	includePage = includePage + ".jsp"; 
	
	// 세션에서 "user" 속성 가져오기 (로그인된 사용자 정보)
	UserVO sessionUser = (UserVO)session.getAttribute("user");
%>
<!DOCTYPE html> <%-- HTML5 문서 선언 --%>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 UTF-8 설정 --%>
<title>Action Tag include</title> <%-- 페이지 제목 설정 --%>
<style type="text/css"> <%-- 페이지 스타일 --%>
	table{ /* 테이블 전체 스타일 */
		width:900px; /* 너비 */
		margin:0 auto; /* 가운데 정렬 */
		text-align:center; /* 텍스트 가운데 정렬 */
		border:1px solid black; /* 테두리 */
	}
	
	table tr td:first-child{ /* 첫 번째 열 스타일 */
		border-right:1px solid gray; /* 오른쪽 테두리 */	
	}
	
	aside ul{ /* aside 영역의 리스트 스타일 */
		list-style:none; /* 리스트 기호 없음 */
		padding-left:10px; /* 왼쪽 패딩 */
		text-align:left; /* 텍스트 왼쪽 정렬 */
		width:130px; /* 너비 */
		height:500px; /* 높이 */
	}
	
	aside ul li a{ /* 링크 스타일 */
		text-decoration:none; /* 밑줄 없음 */
		color:gray; /* 회색 */
	}
	
	aside ul li a:hover{ /* 링크 호버 시 스타일 */
		color:red; /* 빨간색 */
	}
</style>
</head>
<body>
	<table>
		<tr> <%-- 헤더 행 --%>
			<th colspan="2" height="150">  <%-- 두 열 합치기, 높이 설정 --%>
				<h1>HEADER - <%=sessionUser%></h1> <%-- 제목, 세션 사용자 정보 표시 --%>
				<hr/> <%-- 구분선 --%>
			</th>
		</tr>
		<tr>
			<td> <%-- 메뉴 열 --%>
				<aside>
					<ul>
						<%-- 각 메뉴 항목 링크, 페이지 파라미터 전달 --%>
						<li><a href="index.jsp?page=default">HOME</a></li> 
						<li><a href="index.jsp?page=intro">회사소개</a></li>
						<li><a href="index.jsp?page=useBean">USE Bean</a></li>
						<li><a href="index.jsp?page=join">회원가입</a></li>
					</ul>
				</aside>
			</td>
			<td width="790"> <%-- 콘텐츠 열, 너비 설정 --%>
				<%-- JSP 액션 태그를 사용하여 동적으로 includePage 변수에 지정된 페이지 포함 --%>
				<jsp:include page="<%=includePage%>"/>
			</td>
		</tr>
		<tr> <%-- 푸터 행 --%>
			<th colspan="2" height="150"> 
				<hr/>
				<center> <%-- 저작권 표시 가운데 정렬 --%>
					Copyright &copy; 2024.
				</center>
			</th>
		</tr>
	</table>
</body>
</html>
