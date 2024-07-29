<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, util.Criteria, util.PageMaker" %>
<%@ page language="java" %>
<jsp:useBean id="criteria" class="util.Criteria" scope="page" />
<jsp:setProperty name="criteria" property="page" value="${param.page}" />
<jsp:setProperty name="criteria" property="perPageNum" value="${param.perPageNum}" />

<jsp:useBean id="pageMaker" class="util.PageMaker" scope="page" />
<jsp:setProperty name="pageMaker" property="cri" value="${criteria}" />
<jsp:setProperty name="pageMaker" property="displayPageNum" value="10" />
<!DOCTYPE html>
<html>
<head>
    <title>주문 내역</title>
    <!-- Bootstrap CSS -->
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
    <div class="container mt-5">
        <h2 class="mb-4">주문 내역</h2>
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>구매자 이름</th>
                    <th>주소</th>
                    <th>전화번호</th>
                    <th>책 제목</th>
                    <th>수량</th>
                    <th>가격</th>
                    <th>총 가격</th>
                    <th>주문 날짜</th>
                    <th>배송 현황</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    List<Map<String, Object>> orderList = new ArrayList<>();
                    Map<Integer, Integer> totalPriceMap = new HashMap<>();
					int memberNum = 1;
					int orderGroupId = 0;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/baskin";
                        String user = "root";
                        String password = "1234";
                        conn = DriverManager.getConnection(url, user, password);
                  
                        // Total count query for memberNum 1
                        String countQuery = "SELECT COUNT(*) FROM Orders WHERE memberNum = ?";
                        pstmt = conn.prepareStatement(countQuery);
                        pstmt.setInt(1, memberNum);
                        rs = pstmt.executeQuery();
                        if (rs.next()) {
                            pageMaker.setTotalCount(rs.getInt(1));
                        }
                        rs.close();
                        pstmt.close();
				
                        // Data query with LIMIT for memberNum 1
                        String query = "SELECT o.buyer_name, o.buyer_addr, o.buyer_tel, b.book_no, b.title, o.quantity, o.total_price, o.status, o.order_date, o.order_group_id " +
                                       "FROM Orders o " +
                                       "JOIN Books b ON o.book_no = b.book_no " +
                                       "WHERE o.memberNum = ? " +
                                       "ORDER BY o.order_group_id LIMIT ?, ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setInt(1, memberNum);
                        pstmt.setInt(2, criteria.getStartRow());
                        pstmt.setInt(3, criteria.getPerPageNum());
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            Map<String, Object> order = new HashMap<>();
                            order.put("buyer_name", rs.getString("buyer_name"));
                            order.put("buyer_addr", rs.getString("buyer_addr"));
                            order.put("buyer_tel", rs.getString("buyer_tel"));
                            order.put("book_no", rs.getInt("book_no")); // 책 ID 추가
                            order.put("title", rs.getString("title"));
                            order.put("quantity", rs.getInt("quantity"));
                            order.put("total_price", rs.getInt("total_price"));
                            order.put("order_date", rs.getTimestamp("order_date"));
                            order.put("status", rs.getString("status"));
                            order.put("order_group_id", rs.getInt("order_group_id"));
                            orderList.add(order);

                            int currentOrderGroupId = rs.getInt("order_group_id");
                            totalPriceMap.put(currentOrderGroupId, totalPriceMap.getOrDefault(currentOrderGroupId, 0) + rs.getInt("total_price"));
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }

                    int previousOrderGroupId = -1;
                    boolean firstRow = true;

                    for (Map<String, Object> order : orderList) {
                        int currentOrderGroupId = (int) order.get("order_group_id");
                        int totalPriceForGroup = totalPriceMap.get(currentOrderGroupId);

                        if (currentOrderGroupId != previousOrderGroupId) {
                            if (!firstRow) {
                %>
                                <tr><td colspan="9" class="bg-light"></td></tr>
                <%
                            }
                %>
                <tr>
                    <td><%= order.get("buyer_name") %></td>
                    <td><%= order.get("buyer_addr") %></td>
                    <td><%= order.get("buyer_tel") %></td>
                    <td><a href="../new_book_shop_in_from.jsp?book_no=<%= order.get("book_no") %>"><%= order.get("title") %></a></td> <!-- 책 제목에 링크 추가 -->
                    <td><%= order.get("quantity") %></td>
                    <td><%= order.get("total_price") %></td>
                    <td rowspan="<%= totalPriceMap.size() %>"><%= totalPriceForGroup %></td>
                    <td><%= order.get("order_date") %></td>
                    <td><strong><%= order.get("status") %></strong></td>
                </tr>
                <%
                            previousOrderGroupId = currentOrderGroupId;
                            firstRow = false;
                        } else {
                %>
                <tr>
                    <td colspan="3"></td>
                    <td><a href="../new_book_shop_in_from.jsp?book_no=<%= order.get("book_no") %>"><%= order.get("title") %></a></td> <!-- 책 제목에 링크 추가 -->
                    <td><%= order.get("quantity") %></td>
                    <td><%= order.get("total_price") %></td>
                    <td colspan="3"></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <!-- 페이징 -->
        <nav>
            <ul class="pagination justify-content-center">
                <%
                    if (pageMaker.isPrev()) {
                %>
                    <li class="page-item">
                        <a class="page-link" href="?page=<%= pageMaker.getStartPage() - 1 %>&perPageNum=<%= criteria.getPerPageNum() %>">Previous</a>
                    </li>
                <%
                    }

                    for (int i = pageMaker.getStartPage(); i <= pageMaker.getEndPage(); i++) {
                %>
                    <li class="page-item <%= (i == criteria.getPage()) ? "active" : "" %>">
                        <a class="page-link" href="?page=<%= i %>&perPageNum=<%= criteria.getPerPageNum() %>"><%= i %></a>
                    </li>
                <%
                    }

                    if (pageMaker.isNext()) {
                %>
                    <li class="page-item">
                        <a class="page-link" href="?page=<%= pageMaker.getEndPage() + 1 %>&perPageNum=<%= criteria.getPerPageNum() %>">Next</a>
                    </li>
                <%
                    }
                %>
            </ul>
        </nav>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
