<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!-- check.jsp -->
<%
	// 브라우저에서는 요청을 전달 할때마다 해당 사이트에 등록된 쿠키 정보(목록)을 전달
	// 쿠키는 요청 정보인 request에 가공처리되어서 전달됨.	
	
	Cookie[] cookies = request.getCookies();// 현재 요청에 포함된 모든 쿠키를 가져옵니다.
	if(cookies != null){
		// 등록된 쿠키 개수 만큼 순회하면서 출력
		for(Cookie c : cookies){
			String name = c.getName(); 		// 쿠키의 이름(key)을 가져옵니다.
			String value = c.getValue();	// 쿠키의 값(value)을 가져옵니다.
			out.println(name+":"+value+"<br/>");// 쿠키의 이름과 값 출력
		}
		
	}else{
		//등록된 쿠키가 없을 경우
		out.println("<h2>등록된 쿠키가 없습니다.</h2>");	
	}
%>
<hr/>
<h3> Session info</h3>
<% 
	//현재요청이 들어온 사용자의 Session 객체 구분값== id
	String sessionId =session.getId();
	out.println("Session id:"+sessionId+"<br/>");
	
	// 현재 요청에서 새로 생성된 Session 객체인지 여부 확인 
	// 새로 생성된 객체면 true, 이전 요청에서 생성된 객체면 false
	boolean isNew = session.isNew();
	out.println("Session isNew : " + isNew + "<br/>");
%>
