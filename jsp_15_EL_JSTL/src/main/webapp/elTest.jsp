<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>elTest.jsp</title>
</head>
<body>
    <%-- JSP 스크립틀릿: request 파라미터에서 id 값을 가져와 session에 저장 --%>
    <%
        String id = request.getParameter("id");
        session.setAttribute("sessionID", id);
    %>
    
    <%-- EL (Expression Language)을 사용하여 값 출력 --%>
    EL : ${id} <br/>             <%-- requestScope에서 id 값 가져오기 (출력 안됨, 밑에서 requestScope에 setAttribute 해주기 때문) --%>
    EL sessionID : ${sessionID} <br/> <%-- sessionScope에서 sessionID 값 가져오기 --%>
    EL scopeName : ${scopeName} <br/>  <%-- EL이 실행되는 scope의 이름 출력 (pageScope, requestScope, sessionScope, applicationScope 중 하나) --%>
    <br/>

    <%-- JSP 표현식과 EL을 사용하여 값 출력 --%>
    param id : <%= id %> <br/>      <%-- JSP 표현식으로 id 값 출력 --%>
    EL param id : ${param.id} <br/> <%-- EL로 param 객체의 id 속성 값 출력 --%>

    <%-- input 태그의 value 속성에 JSP 표현식과 EL을 사용하여 값 설정 --%>
    <input type="text" value="<%=id%>"/> <br/>  <%-- JSP 표현식 사용 --%>
    <input type="text" value="${param.id}"/>  <%-- EL 사용 --%>

    <hr/>

    <h2>EL 표현언어 내부에서의 연산</h2>
    <%-- 다양한 연산 예제 --%>
    <h3>\${5 + 7} : ${5 + 7} </h3>   <%-- 산술 연산 --%>
    <h3>\${ 5 == 7 } : ${5 == 7} </h3> <%-- 비교 연산 --%>
    <h3>\${5 + 7 > 8 ? '크다' : '작다'} : ${5 + 7 > 8 ? '크다' : '작다'}</h3>  <%-- 삼항 연산자 --%>

    <%-- 문자열 비교 예제 --%>
    <%
        String s  = "a";
        String s1 = new String("hi?");
        String s2 = new String("attribute");
        String s3 = new String("attribute");
        request.setAttribute("s" , s);
        request.setAttribute("s1" , s1);
        request.setAttribute("s2" , s2);
        request.setAttribute("s3" , s3); 
    %>
    <%= s == s1 %> <br/>  <%-- JSP 표현식: 레퍼런스 비교 (false) --%>
    <%= s2 == s3 %> <br/>  <%-- JSP 표현식: 레퍼런스 비교 (false) --%>
    <%= s2.equals(s3) %> <br/> <%-- JSP 표현식: 값 비교 (true) --%>

    <%-- EL을 사용한 문자열 비교 --%>
    <h3>\${s == s1} : ${s == s1} </h3>  <%-- EL: 값 비교 (false) --%>
    <h3>\${s2 == s3} : ${s2 == s3} </h3>  <%-- EL: 값 비교 (true) --%>
    <h3>\${s2 != s3} : ${s2 != s3} </h3> <%-- EL: 값 비교 (false) --%>
    <h3>\${s2 eq s3} : ${s2 eq s3} </h3> <%-- EL: equals 메서드 사용 (true) --%>
    <h3>\${s2 ne s3} : ${s2 ne s3} </h3> <%-- EL: not equals 메서드 사용 (false) --%>
    <hr/>

    <%-- EL을 사용한 논리 연산 --%>
    <h3>\${s != s2 && s2 == s3} : ${s != s2 && s2 == s3}</h3>
    <h3>\${s != s2 and s2 == s3} : ${s != s2 and s2 == s3}</h3>
    <h3>\${s != s2 || s2 == s3} : ${s != s2 || s2 == s3}</h3>
    <h3>\${s != s2 or s2 == s3} : ${s != s2 or s2 == s3}</h3>
    <hr/>
    <h3>\${s1 eq "hi?"} : ${s1 eq "hi?"}</h3>
    <h3>\${s1 ne "hi?"} : ${s1 ne "hi?"}</h3>

    <%-- 빈 리스트 확인 --%>
    <%
        java.util.ArrayList<String> list = null;  
        request.setAttribute("memberList" , list);
    %>
    <h3>\${empty memberList} : ${empty memberList}</h3>  <%-- null 또는 비어있는 경우 true --%>
    <h3>\${not empty memberList} : ${not empty memberList}</h3> <%-- null 또는 비어있는 경우 false --%>

    <%
        list = new java.util.ArrayList<>();
        request.setAttribute("memberList" , list);
    %>
    <h3>\${memberList.isEmpty()} : ${memberList.isEmpty()}</h3>
    <h3>\${empty memberList} : ${empty memberList}</h3>
    <h3>\${! empty memberList} : ${! empty memberList}</h3>

    <%
        list.add("최기근");
    %>
    <h3>\${empty memberList} : ${empty memberList}</h3>
</body>
</html>
