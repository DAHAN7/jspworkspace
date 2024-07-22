<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%-- JSP 페이지 설정: 자바 언어 사용, 문자셋 UTF-8, 페이지 인코딩 UTF-8 --%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %> <%-- JDBC 관련 클래스 import --%>

<%-- 게시글 작성 완료 페이지 --%>
<%-- 게시글 작성 요청 처리 --%>
<%
	String board_name = request.getParameter("board_name"); // 폼에서 전송된 작성자 이름 가져오기
	String board_pass = request.getParameter("board_pass"); // 폼에서 전송된 비밀번호 가져오기
	String board_title = request.getParameter("board_title"); // 폼에서 전송된 글 제목 가져오기
	String board_content = request.getParameter("board_content"); // 폼에서 전송된 글 내용 가져오기

	Connection conn = null; // DB 연결 객체
	PreparedStatement pstmt = null; // SQL 실행 객체
	int result = 0; // 쿼리 실행 결과

	try {
		// Connection Pool 을 이용해서 Connection 객체 받기 (Tomcat 환경)
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQLDB"); 
		conn = ds.getConnection();

		/*
		// JDBC 드라이버 로드 및 DB 연결 (직접 연결, Tomcat 미사용 시)
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/digital_jsp",
			"digital",
			"1234"
		);
		*/

		// SQL 쿼리 준비 및 실행 (PreparedStatement 사용)
		String sql = "INSERT INTO test_board VALUES(null,?,?,?,?,0,now())"; 
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board_name); // 첫 번째 물음표에 작성자 이름 설정
		pstmt.setString(2, board_pass); // 두 번째 물음표에 비밀번호 설정
		pstmt.setString(3, board_title); // 세 번째 물음표에 글 제목 설정
		pstmt.setString(4, board_content); // 네 번째 물음표에 글 내용 설정

		result = pstmt.executeUpdate(); // 쿼리 실행 및 결과 저장

	} catch(Exception e) {
		e.printStackTrace(); // 예외 발생 시 콘솔에 출력
	} finally {
		// 자원 해제 (PreparedStatement, Connection)
		if(pstmt != null) {
			pstmt.close();
		}
		if(conn != null) {
			conn.close();
		}
	}
%>

<%-- 게시글 작성 결과 처리 --%>
<%
	if(result == 1) { // 쿼리 실행 성공 (1개 행 삽입)
%>
	<script>
		alert("게시글 등록 성공!");
		location.href='board_list.jsp'; // 게시글 목록 페이지로 이동
	</script>
<%		
	} else { // 쿼리 실행 실패
%>
	<script>
		alert('게시글 등록 실패');
		history.go(-1); // 이전 페이지로 이동
	</script>
<%		
	}
%>
