<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="text-center">장바구니</h1>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>작업</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");
                    if (cart != null && !cart.isEmpty()) {
                        for (HashMap<String, String> item : cart) {
                %>
                <tr>
                    <td><%= item.get("product") %></td>
                    <td><%= item.get("price") %> 원</td>
                    <td>
                        <form action="remove_from_cart.jsp" method="post">
                            <input type="hidden" name="product" value="<%= item.get("product") %>">
                            <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3" class="text-center">장바구니가 비어 있습니다.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <a href="products.jsp" class="btn btn-secondary btn-block">계속 쇼핑하기</a>
        <form action="checkout.jsp" method="post">
            <button type="submit" class="btn btn-primary btn-block">결제하기</button>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
