-<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%
    String productToRemove = request.getParameter("product");

    ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");
    if (cart != null) {
        // 장바구니에서 선택된 상품을 제거
        cart.removeIf(item -> item.get("product").equals(productToRemove));
        session.setAttribute("cart", cart);
    }

    // 장바구니 페이지로 리다이렉션
    response.sendRedirect("cart.jsp");
%>
