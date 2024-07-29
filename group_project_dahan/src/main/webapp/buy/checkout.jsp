<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    // 세션에서 장바구니 정보를 가져옴
    ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");
    session.setAttribute("purchaseList", cart);

    // 결제 페이지로 리디렉션
    response.sendRedirect("payment.jsp");
%>
