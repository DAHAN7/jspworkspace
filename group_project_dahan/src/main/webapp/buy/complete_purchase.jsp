<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String impUid = request.getParameter("imp_uid");
    String merchantUid = request.getParameter("merchant_uid");
    String paidAmount = request.getParameter("paid_amount");
    String applyNum = request.getParameter("apply_num");

    String buyerName = request.getParameter("buyer_name");
    String buyerTel = request.getParameter("buyer_tel");
    String buyerAddr = request.getParameter("buyer_addr");

    // 세션에서 장바구니와 구매 목록 가져오기
    ArrayList<HashMap<String, String>> purchaseList = (ArrayList<HashMap<String, String>>) session.getAttribute("purchaseList");

    // 파일에 결제 정보를 저장
    String filePath = application.getRealPath("/") + "WEB-INF/purchase_data.txt";
    try (FileWriter fw = new FileWriter(filePath, true);
         PrintWriter pw = new PrintWriter(fw)) {
        for (HashMap<String, String> item : purchaseList) {
            pw.println("이름: " + buyerName);
            pw.println("주소: " + buyerAddr);
            pw.println("전화번호: " + buyerTel);
            pw.println("결제상품: " + item.get("product"));
            pw.println("가격: " + item.get("price"));
            pw.println("----------");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 세션에서 장바구니와 구매 목록 정보 삭제
    session.removeAttribute("cart");
    session.removeAttribute("purchaseList");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 완료</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="text-center">결제 완료</h1>
        <p class="text-center">결제가 완료되었습니다. 감사합니다!</p>
        <a href="products.jsp" class="btn btn-primary btn-block">다시 쇼핑하기</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
