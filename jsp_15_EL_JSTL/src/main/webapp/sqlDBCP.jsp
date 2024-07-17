<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DataBase Connection Pool</title>
</head>
<body>

    <%@ page import="javax.naming.*, javax.sql.*, java.sql.*" %> 
    <%
        // 데이터베이스 연결 및 조회 관련 클래스 import

        /* 톰캣 서버에 설정된 리소스 정보를 저장하는 InitialContext 객체 생성 */
        Context init = new InitialContext(); 

        // lookup(): "java:comp/env" 환경 설정 정보를 찾아 Context 객체에 저장
        init = (Context)init.lookup("java:comp/env"); 

        // lookup(): "java/testVO" 이름으로 설정된 리소스를 찾아 객체에 저장 (예시)
        Object obj = init.lookup("java/testVO"); 
        out.println(obj + "<br/>"); 

        /*
            JNDI(Java Naming and Directory Interface): 
            - 이름을 사용하여 데이터 및 객체를 찾고 관리하는 API
            - 톰캣 서버의 설정된 데이터 소스를 이름으로 찾아 연결하는데 사용
        */

        // lookup(): "java/MySQLDB" 이름으로 설정된 데이터 소스(DataSource)를 가져옴
        DataSource ds = (DataSource)init.lookup("java/MySQLDB"); 

        // getConnection(): 데이터 소스를 통해 데이터베이스 연결(Connection) 객체를 획득
        Connection conn = ds.getConnection(); 
        out.println(conn + "<br/>"); 

        // 이후 획득한 conn 객체를 사용하여 데이터베이스 작업 수행 (SQL 쿼리 실행 등)
    %>

</body>
</html>
