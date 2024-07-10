<%@ page language="java" contentType="text/html; charset=UTF-8" %><%-- JSP 페이지 설정 (언어: Java, 콘텐츠 타입: HTML, 문자 인코딩: UTF-8) --%>
<!-- guest_book_write.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <%-- 문자 인코딩 설정 --%>
<title>방명록 등록 요청 처리</title>
</head>
<body>
	<h1>방명록 등록 페이지</h1>
	<%@ page import="java.sql.*" %>
	<%
	// 1. 사용자 입력 데이터 받기 (guest_book.jsp에서 넘어온 데이터)
		String guestName = request.getParameter("guestName");
		String password = request.getParameter("password");
		String message = request.getParameter("message");  
		
		Connection conn = null;// 데이터베이스 연결 객체
		PreparedStatement pstmt = null;// SQL 실행 객체
		// 처리 결과를 저장할 변수
		String resultMsg = ""; // 처리 결과 메시지 저장 변수
		
		try{
			// Driver class load
			// 2. JDBC 드라이버 로드 (MySQL Connector/J)
			Class.forName("com.mysql.cj.jdbc.Driver");

			// 3. 데이터베이스 연결
			conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/digital_jsp",	// 연결할 db server schema
				"digital",									// 권한있는 계정 id
				"1234"										// 비밀번호
			);
			out.println("DB 연결 완료 " + conn);// 연결 확인 (개발 단계에서만 사용)
			
			String sql = "INSERT INTO guestBook VALUES(null, ?, ?, ?)"; // 자동 증가 ID, 이름, 비밀번호, 메시지
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, guestName); // 첫 번째 ?에 이름 설정
			pstmt.setString(2, password); // 두 번째 ?에 비밀번호 설정
			pstmt.setString(3, message);  // 세 번째 ?에 메시지 설정
			// 5. SQL 실행 및 결과 처리
			int result = pstmt.executeUpdate(); // INSERT 실행
			
			resultMsg = (result > 0) ? "방명록 등록 성공" : "방명록 등록 실패";// 성공/실패 메시지 설정
			
			
		}catch(ClassNotFoundException e){ // JDBC 드라이버 로드 실패 시 예외 처리
			out.println("Driver class를 찾을 수 없음<br/>");
		}catch(SQLException e){ // SQL 실행 시 예외 처리
			out.println("DB 연결 정보 오류 <br/>");
		}finally{ // 예외 발생 여부와 상관없이 항상 실행되는 블록
			// 6. 자원 해제
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
	%>
	
	<!-- 방명록 작성 후 처리결과 출력 -->
	<h2><%=resultMsg%></h2>
	<a href="guest_book.jsp">방명록 목록 보기</a><%-- 방명록 목록 페이지로 이동 --%>
	
</body>
</html>