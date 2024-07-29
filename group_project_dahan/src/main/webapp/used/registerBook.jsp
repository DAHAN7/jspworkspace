<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    boolean success = false;

    try {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        int price = Integer.parseInt(request.getParameter("price"));
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imagePath = request.getParameter("image_path");
        int sellerId = Integer.parseInt(request.getParameter("seller_id"));

        Context initContext = new InitialContext();
        Context envContext  = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/baskin");
        conn = ds.getConnection();

        String sql = "INSERT INTO books (title, author, publisher, price, status, description, category, stock, image_path, seller_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, title);
        stmt.setString(2, author);
        stmt.setString(3, publisher);
        stmt.setInt(4, price);
        stmt.setString(5, status);
        stmt.setString(6, description);
        stmt.setString(7, category);
        stmt.setInt(8, stock);
        stmt.setString(9, imagePath);
        stmt.setInt(10, sellerId);

        int rowCount = stmt.executeUpdate();
        success = rowCount > 0;
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    if (success) {
        response.sendRedirect("registerSuccess.jsp");
    } else {
        response.sendRedirect("registerFailure.jsp");
    }
%>
