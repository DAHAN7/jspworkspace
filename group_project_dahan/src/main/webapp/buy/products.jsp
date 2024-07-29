<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 페이지</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> <!-- SweetAlert2 추가 -->
</head>
<body>
    <div class="container">
        <h1 class="text-center">상품 페이지</h1>
        <div class="row">
            <!-- 상품 1 -->
            <div class="col-md-3">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">후드티</h5>
                        <p class="card-text">가격: 1원</p>
                        <form action="add_to_cart.jsp" method="post" id="form_hoodie">
                            <input type="hidden" name="product" value="후드티">
                            <input type="hidden" name="price" value="1">
                            <button type="submit" class="btn btn-primary btn-block">장바구니에 담기</button>
                            <button type="button" class="btn btn-success btn-block" onclick="buyNow('후드티', '1')">바로 구매</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- 상품 2 -->
            <div class="col-md-3">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">청바지</h5>
                        <p class="card-text">가격: 2원</p>
                        <form action="add_to_cart.jsp" method="post" id="form_jeans">
                            <input type="hidden" name="product" value="청바지">
                            <input type="hidden" name="price" value="2">
                            <button type="submit" class="btn btn-primary btn-block">장바구니에 담기</button>
                            <button type="button" class="btn btn-success btn-block" onclick="buyNow('청바지', '2')">바로 구매</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- 상품 3 -->
            <div class="col-md-3">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">티셔츠</h5>
                        <p class="card-text">가격: 3원</p>
                        <form action="add_to_cart.jsp" method="post" id="form_tshirt">
                            <input type="hidden" name="product" value="티셔츠">
                            <input type="hidden" name="price" value="3">
                            <button type="submit" class="btn btn-primary btn-block">장바구니에 담기</button>
                            <button type="button" class="btn btn-success btn-block" onclick="buyNow('티셔츠', '3')">바로 구매</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- 상품 4 -->
            <div class="col-md-3">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">운동화</h5>
                        <p class="card-text">가격: 4원</p>
                        <form action="add_to_cart.jsp" method="post" id="form_sneakers">
                            <input type="hidden" name="product" value="운동화">
                            <input type="hidden" name="price" value="4">
                            <button type="submit" class="btn btn-primary btn-block">장바구니에 담기</button>
                            <button type="button" class="btn btn-success btn-block" onclick="buyNow('운동화', '4')">바로 구매</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- 상품 5 -->
            <div class="col-md-3">
                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">모자</h5>
                        <p class="card-text">가격: 5원</p>
                        <form action="add_to_cart.jsp" method="post" id="form_hat">
                            <input type="hidden" name="product" value="모자">
                            <input type="hidden" name="price" value="5">
                            <button type="submit" class="btn btn-primary btn-block">장바구니에 담기</button>
                            <button type="button" class="btn btn-success btn-block" onclick="buyNow('모자', '5')">바로 구매</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <a href="cart.jsp" class="btn btn-secondary btn-block">장바구니 보기</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#form_hoodie').submit(function(e) {
                e.preventDefault();
                addToCart('후드티', '1');
            });

            $('#form_jeans').submit(function(e) {
                e.preventDefault();
                addToCart('청바지', '2');
            });

            $('#form_tshirt').submit(function(e) {
                e.preventDefault();
                addToCart('티셔츠', '3');
            });

            $('#form_sneakers').submit(function(e) {
                e.preventDefault();
                addToCart('운동화', '4');
            });

            $('#form_hat').submit(function(e) {
                e.preventDefault();
                addToCart('모자', '5');
            });
        });

        function addToCart(product, price) {
            $.post('add_to_cart.jsp', { product: product, price: price }, function(data) {
                Swal.fire({
                    icon: 'success',
                    title: '장바구니에 추가되었습니다!',
                    text: product + ' - ' + price + '원',
                    showConfirmButton: false,
                    timer: 1500
                });
            });
        }

        function buyNow(product, price) {
            $.post('set_purchase_session.jsp', { product: product, price: price }, function(data) {
                window.location.href = 'payment.jsp';
            });
        }
    </script>
</body>
</html>
