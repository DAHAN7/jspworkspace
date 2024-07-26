<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!-- getBalance.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>잔액 확인</title>
</head>
<body>
	<%@page import="net.nurigo.sdk.message.service.DefaultMessageService"%>
	<%@page import="net.nurigo.sdk.NurigoApp"%>
	<%@page import="net.nurigo.sdk.message.model.Balance"%>
	<%
		DefaultMessageService messageService;
	 	// 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
	    messageService = NurigoApp.INSTANCE.initialize(
	    		"NCSB6HIC71CC9FMP", 					// API 키
	    		"9SCD8GTUN7WD5TRTYL2RP7WYCYJKMSFS", 	// API Secret Key
	    		"https://api.coolsms.co.kr");
	
	
	    Balance balance = messageService.getBalance();
        out.println(balance);
	%>
</body>
</html>

