<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!-- index.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.Connection" %>
	<%@ page import="java.sql.DriverManager" %>
	<%@ page import="java.sql.SQLException" %>
	<%
		// Driver class 이름(위치)
		String driver = "com.mysql.cj.jdbc.Driver";	
		// database 에 연결하기 위한 정보
		String url = "jdbc:mysql://localhost:3306/digital_jsp";
		String username = "digital";
		String password = "1234";
		
		// 연결정보를 이용해서 database에 연결된 정보를 저장하는 객체
		Connection conn = null;
		
		try{
			Class.forName(driver);
			out.println("Driver class 존재");
			
			conn = DriverManager.getConnection(
				url,username,password
			);
			out.println("DB 연결 완료 : ");
			out.println(conn + "<br/>");
		}catch(ClassNotFoundException e){
			out.println("Driver class를 찾을 수 없음");
		}catch(SQLException e){
			out.println("DB 연결 요청 오류 : " + e.getMessage() + "<br/>");
		}finally{
			if(conn != null){
				conn.close();
			}
		}
	%>
	
	<h3><a href="insertForm.jsp">회원정보 입력</a></h3>
	<h3><a href="memberList.jsp">회원 목록</a></h3>
	<h3><a href="login.jsp">Statement Test</a></h3>
</body>
</html>