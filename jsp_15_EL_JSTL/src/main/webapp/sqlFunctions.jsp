<%@ page language="java" contentType="text/html; charset=UTF-8" %> <%-- 페이지 지시어: 자바 코드 사용, HTML 콘텐츠 유형, UTF-8 문자 인코딩 설정 --%>
<%-- JSP 파일 이름 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL 코어 태그 라이브러리: 변수 설정, 조건문, 반복문 등 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%-- JSTL 함수 태그 라이브러리: 문자열 조작 함수 제공 --%>

<!DOCTYPE html> <%-- HTML5 문서임을 선언 --%>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 설정 --%>
<title>Insert title here</title> <%-- 페이지 제목 --%>
</head>
<body>

	<%-- JSTL 코어 태그와 함수 태그를 사용한 문자열 조작 예시 --%>

	<c:set var="test" value="Hello, Java Server Page!"/> <%-- 변수 "test"에 문자열 값 설정 --%>
	EL test : ${test} <br/> <%-- EL(Expression Language)을 사용하여 변수 "test"의 값 출력 --%>
	toUpperCase : ${fn:toUpperCase(test)} <br/> <%-- toUpperCase 함수: 대문자로 변환 --%>
	toLowerCase : ${fn:toLowerCase(test)} <br/> <%-- toLowerCase 함수: 소문자로 변환 --%>

	<c:set var="img" value="image/png" /> <%-- MIME 타입(이미지/png) 변수 설정 --%> 
	<c:if test="${fn:startsWith(img, 'image')}"> <%-- startsWith 함수: 문자열이 특정 문자열로 시작하는지 확인 --%>
		이미지 파일입니다. <br/> 
	</c:if>

	<c:set var="text" value="readme.txt"/> <%-- 파일 이름 변수 설정 --%>
	<c:choose> <%-- choose-when-otherwise 구조: switch-case 문과 유사 --%>
		<c:when test="${fn:endsWith(text, 'txt')}"> <%-- endsWith 함수: 문자열이 특정 문자열로 끝나는지 확인 --%>
			텍스트 파일입니다. <br/>
		</c:when>
		<c:otherwise>
			텍스트 파일 아입니더. <br/>
		</c:otherwise>
	</c:choose>
	
	contains : ${fn:contains(test, 'java')} <br/> <%-- contains 함수: 문자열이 특정 문자열을 포함하는지 확인(대소문자 구분) --%>
	containsIgnoreCase : ${fn:containsIgnoreCase(test, 'java')} <br/> <%-- containsIgnoreCase 함수: 문자열이 특정 문자열을 포함하는지 확인(대소문자 구분 없음) --%>
	<hr/>

	indexOf : ${fn:indexOf(test, 'java')} <br/> <%-- indexOf 함수: 특정 문자열의 시작 인덱스 반환 --%>
	substringBefore : ${fn:substringBefore(test, 'Java')} <br/> <%-- substringBefore 함수: 특정 문자열 이전 부분 추출 --%>
	substringAfter : ${fn:substringAfter(test, 'Java')} <br/> <%-- substringAfter 함수: 특정 문자열 이후 부분 추출 --%>
	substring : ${fn:substring(test, fn:indexOf(test, 'Java'), 11)} <br/> <%-- substring 함수: 특정 범위의 문자열 추출 --%>
	<hr/>

	<c:set var="strs" value="${fn:split(test, ' ')}"/> <%-- split 함수: 문자열을 특정 구분자로 분리하여 배열 생성 --%>
	strs 배열의 길이 : ${fn:length(strs)} <br/> <%-- length 함수: 배열 또는 문자열의 길이 반환 --%>
	<c:forEach var="str" items="${strs}"> <%-- forEach 반복문: 배열의 각 요소에 대해 반복 --%>
		${str} <%-- 배열 요소 출력 --%>
	</c:forEach>
	<br/>
	${fn:join(strs,'|')} <br/> <%-- join 함수: 배열의 요소들을 특정 구분자로 연결하여 문자열 생성 --%>

	<hr/>
	
	<%-- HTML 태그 이스케이프 및 치환 예시 --%>
	<div style='border:1px solid red'>안녕하세요! 배고프죠?!</div>
	<c:set var="tag" value="<div style='border:1px solid red'>안녕하세요! 배고프죠?!</div>"/>
	${tag} <hr/><br/> <%-- 태그가 그대로 출력됨 --%>
	escapeXml : ${fn:escapeXml(tag)} <br/> <%-- escapeXml 함수: HTML 특수 문자 이스케이프 --%>
	<hr/>
	${fn:replace(tag, '<', '&lt;')} <br/> <%-- replace 함수: 문자열 치환 --%> 
</body>
</html>
