<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>attrTest1.jsp</title>
</head>
<body>
	<%
		// request 객체로부터 "id"파라미터 값을 가져옵니다.
		String id = request.getParameter("id");
		
		// id != null : id라는 name으로 전달된 parameter가 존재할때
		// !id.equals("") : 작성한 텍스트가 빈 문자열이 아닐 때
		if(id != null && !id.equals("")){
			// key type은 문자열(String)
			// value type은 Object
			pageContext.setAttribute("pageId", id);
			application.setAttribute("appId", id);
		}
	%>
	<h2>저장된 정보 확인</h2>
	<%
		// application 영역 객체에 저장된 속성 값들 중에
		// name(key) 가 appId인 속성 값 
		Object appId = application.getAttribute("appId");
		// pageContext 영억에서 "pageId" 속성값을 가져옵니다.	
		String pageId = (String)pageContext.getAttribute("pageId");
		
	%>
	<!-- pageCongext와 application영역에 저장된 id값을 출력합니다. -->
	<h3>pageContext id : <%= pageId %></h3>
	<h3>application id : <%= appId %></h3>
	<hr/>
	<!-- 이메일을 입력받기 위한 폼 -->
	<form action="attrTest2.jsp" method="POST">
		이메일 : <input type="email" name="email" required/>
		<button>확인</button>	
	</form>
</body>
</html>










