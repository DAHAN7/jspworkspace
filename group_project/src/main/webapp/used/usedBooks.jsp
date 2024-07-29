<%@ page import="java.io.*, java.util.*, jakarta.servlet.*, jakarta.servlet.http.*" %>
<%@ page import="java.sql.*" %>

<%
  // 데이터베이스 연결 정보
  String jdbcUrl = "jdbc:mysql://localhost:3306/used-bookstore"; // MySQL 사용 예시
  String dbUser = "your_username"; // 데이터베이스 사용자 이름
  String dbPassword = "your_password"; // 데이터베이스 비밀번호

  // 파일 업로드 설정
  String uploadPath = getServletContext().getRealPath("/") + "uploads";
  int maxFileSize = 1024 * 1024; // 1MB
  try {
	    MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, "utf-8");

	    // 폼 데이터 가져오기 (null 체크 추가)
	    String title = multi.getParameter("book-title");
	    String author = multi.getParameter("book-author");
	    String isbn = multi.getParameter("book-isbn");
	    int price = Integer.parseInt(multi.getParameter("book-price") != null ? multi.getParameter("book-price") : "0"); // 가격 기본값 0 설정
	    String condition = multi.getParameter("book-condition");
	    String description = multi.getParameter("book-description");

	    // 이미지 파일 처리
	    Enumeration files = multi.getFileNames();
	    List<String> imagePaths = new ArrayList<>();
	    while (files.hasMoreElements()) {
	      String name = (String) files.nextElement();
	      String filename = multi.getFilesystemName(name);
	      if (filename != null) { 
	        imagePaths.add("/uploads/" + filename); // 이미지 경로를 리스트에 추가
	      }
	    }

	    // 데이터베이스에 저장 (PreparedStatement 사용)
	    try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
	         PreparedStatement stmt = conn.prepareStatement(
	           "INSERT INTO books (title, author, isbn, price, condition, description, images) VALUES (?, ?, ?, ?, ?, ?, ?)"
	         )) {

	      stmt.setString(1, title);
	      stmt.setString(2, author);
	      stmt.setString(3, isbn);
	      stmt.setInt(4, price);
	      stmt.setString(5, condition);
	      stmt.setString(6, description);
	      stmt.setString(7, String.join(",", imagePaths)); // 이미지 경로들을 쉼표로 구분하여 저장
	      stmt.executeUpdate();
	    } catch (SQLException e) {
	      // 데이터베이스 오류 처리
	      out.print("{\"result\": \"error\", \"message\": \"데이터베이스 오류: " + e.getMessage() + "\"}");
	      return;
	    }

	    // 성공 응답
	    out.print("{\"result\": \"success\"}");

	  } catch (IOException e) {
	    // 파일 업로드 오류 처리
	    out.print("{\"result\": \"error\", \"message\": \"파일 업로드 오류: " + e.getMessage() + "\"}");
	  } 
	%>