<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, utils.JDBCUtil" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%
		String userId = (String) session.getAttribute("userId");
		if(userId == null){
	%>
		<script>
			alert("로그인을하고사용해주세요");
			history.back();
		</script>
	<%
		}
	%>
    <div class="container">
        <h1 class="text-center">장바구니</h1>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>합계</th>
                    <th>작업</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        conn = JDBCUtil.getConnection();
                        String sql = "SELECT B.title, C.price, C.quantity, (C.price * C.quantity) as total_price, C.book_no " +
                                     "FROM Cart C JOIN Books B ON C.book_no = B.book_no " +
                                     "WHERE C.memberNum = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, 1/* 여기에 로그인된 사용자 ID를 입력하세요 */);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String title = rs.getString("title");
                            int price = rs.getInt("price");
                            int quantity = rs.getInt("quantity");
                            int total_price = rs.getInt("total_price");
                            int book_no = rs.getInt("book_no");
                %>
                <tr>
                    <td><%= title %></td>
                    <td><%= price %></td>
                    <td><%= quantity %></td>
                    <td><%= total_price %></td>
                    <td>
                        <a href="removeFromCart.jsp?book_no=<%= book_no %>" class="btn btn-danger">삭제</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        JDBCUtil.close(rs, pstmt, conn);
                    }
                %>
            </tbody>
        </table>
        <a href="../index.jsp" class="btn btn-secondary btn-block">계속 쇼핑하기</a>
        <form action="payment.jsp" method="post">
            <button type="submit" class="btn btn-primary btn-block">결제하기</button>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
