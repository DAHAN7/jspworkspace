<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 페이지</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="text-center">결제 페이지</h1>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>상품명</th>
                    <th>가격</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<HashMap<String, String>> purchaseList = (ArrayList<HashMap<String, String>>) session.getAttribute("purchaseList");
                    int totalPrice = 0;
                    if (purchaseList != null && !purchaseList.isEmpty()) {
                        for (HashMap<String, String> item : purchaseList) {
                            totalPrice += Integer.parseInt(item.get("price"));
                %>
                <tr>
                    <td><%= item.get("product") %></td>
                    <td><%= item.get("price") %> 원</td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="2" class="text-center">구매할 상품이 없습니다.</td>
                </tr>
                <%
                    }
                %>
                <tr>
                    <td><strong>총 가격</strong></td>
                    <td><%= totalPrice %> 원</td>
                </tr>
            </tbody>
        </table>
        <button type="button" class="btn btn-success btn-block" data-toggle="modal" data-target="#paymentModal">결제</button>
    </div>

    <!-- 결제 모달 -->
    <div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="paymentModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="paymentModalLabel">결제 정보 입력</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="payment-form">
                        <div class="form-group">
                            <label for="buyer_name">이름</label>
                            <input type="text" class="form-control" id="buyer_name" name="buyer_name" required>
                        </div>
                        <div class="form-group">
                            <label for="buyer_tel">전화번호</label>
                            <input type="tel" class="form-control" id="buyer_tel" name="buyer_tel" required>
                        </div>
                        <div class="form-group">
                            <label for="buyer_addr">주소</label>
                            <input type="text" class="form-control" id="buyer_addr" name="buyer_addr" required>
                        </div>
                        <div class="form-group">
                            <label for="pay_method">결제 방식</label>
                            <select class="form-control" id="pay_method" name="pay_method" required>
                                <option value="kakaopay">카카오페이</option>
                                <option value="html5_inicis">카드결제</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-success" onclick="requestPay()">결제 완료</button>
                </div>
            </div>
        </div>
    </div>

    <script>
    function requestPay() {
        var IMP = window.IMP; 
        IMP.init('imp20622085'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

        var buyer_name = document.getElementById('buyer_name').value;
        var buyer_tel = document.getElementById('buyer_tel').value;
        var buyer_addr = document.getElementById('buyer_addr').value;
        var pay_method = document.getElementById('pay_method').value;
        var totalPrice = <%= totalPrice %>;

        IMP.request_pay({
            pg: pay_method, // 결제 방식
            pay_method: 'card', // 결제수단
            merchant_uid: 'merchant_' + new Date().getTime(), // 주문번호
            name: '구매 상품 목록', // 주문명
            amount: totalPrice, // 결제 금액
            buyer_name: buyer_name,
            buyer_tel: buyer_tel,
            buyer_addr: buyer_addr
        }, function(rsp) {
            if (rsp.success) {
                console.log("결제 성공:", rsp);
                // 결제 성공 시 로직
                $.post('complete_purchase.jsp', {
                    imp_uid: rsp.imp_uid,
                    merchant_uid: rsp.merchant_uid,
                    paid_amount: rsp.paid_amount,
                    apply_num: rsp.apply_num,
                    buyer_name: buyer_name,
                    buyer_tel: buyer_tel,
                    buyer_addr: buyer_addr
                }, function(data) {
                    alert('결제가 완료되었습니다.');
                    window.location.href = 'complete_purchase.jsp';
                });
            } else {
                console.log("결제 실패:", rsp);
                // 결제 실패 시 로직
                alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
            }
        });
    }

    $(document).ready(function() {
        $('#paymentModal').on('hidden.bs.modal', function () {
            $('#payment-form')[0].reset();
        });
    });
    </script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
