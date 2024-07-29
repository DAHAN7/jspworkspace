<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.DataSource, java.io.*, java.util.*" %>
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    boolean success = false;

    
    String categoryOverseas = null;
    String categoryAll =  null;
    
    try {
    	
    	String path = application.getRealPath("img");
    	System.out.println(path);
    	File file =  new File(path);
    	System.out.println("path 생성");
    	if(!file.exists()){
    		file.mkdirs();
    	}
    	
    	/* 
    		registerUsedBook.jsp
    		name에 맞게 파라미터 이름 수정
    	
    	*/
    	  String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String bookMemo = request.getParameter("book_memo");
        String newOldEbook = request.getParameter("new_old_ebook");
        int price = Integer.parseInt(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        categoryOverseas = request.getParameter("category_overseas");
        String categoryAge = request.getParameter("category_age");
        categoryAll = request.getParameter("category_all");
        String book_id = request.getParameter("book_id");
        
        
        String bookFileName = null;
        
        Collection<Part> parts = request.getParts();
        
        if(parts != null){
        	for(Part p : parts){
        		if(p != null && p.getContentType() != null && p.getName().equals("book_fileName") && p.getSize() > 0){
					String  original = p.getSubmittedFileName();
					UUID uid = UUID.randomUUID();
					bookFileName = uid.toString().replace("-","") + "_" + original;
					System.out.println(bookFileName);
					p.write(path + File.separator + bookFileName);
					p.delete();
        			break;
        		}
        	}
        }
        
        
        int sellerId = Integer.parseInt(request.getParameter("seller_id"));

        Context initContext = new InitialContext();
        Context envContext  = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/MySQLDB");
        conn = ds.getConnection();

        String sql = "INSERT INTO books (title, author, publisher, book_memo, new_old_ebook, price, stock, category_overseas, category_age, category_all, book_fileName, seller_id, book_id) VALUES (?, ?, ?, ?, 'old', ?, ?, ?, ?, ?, ?, ?,?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, title);
        stmt.setString(2, author);
        stmt.setString(3, publisher);
        stmt.setString(4, bookMemo);
        stmt.setInt(5, price);
        stmt.setInt(6, stock);
        stmt.setString(7, categoryOverseas);
        stmt.setString(8, categoryAge);
        stmt.setString(9, categoryAll);
        stmt.setString(10, bookFileName);
        stmt.setInt(11, sellerId);
        stmt.setString(12, book_id);

        int rowCount = stmt.executeUpdate();
        
        success = rowCount > 0;
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    if (success) {
        response.sendRedirect("registerSuccess.jsp?category_overseas="+URLEncoder.encode(categoryOverseas)+"&category_all="+categoryAll);
    } else {
        response.sendRedirect("registerFailure.jsp");
    }
%>
