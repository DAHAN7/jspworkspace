<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    String product = request.getParameter("product");
    String price = request.getParameter("price");

    // 세션에서 구매 목록 정보를 가져옴
    ArrayList<HashMap<String, String>> purchaseList = new ArrayList<>();
    HashMap<String, String> item = new HashMap<>();
    item.put("product", product);
    item.put("price", price);
    purchaseList.add(item);

    session.setAttribute("purchaseList", purchaseList);

    // 결제 페이지로 리디렉션
    response.sendRedirect("payment.jsp");
%>
