<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="servlet.*, java.sql.*" %>
<%@ page import="jakarta.mail.*, jakarta.mail.internet.*" %>
<%@ page import="mail.EmailAuthenticator" %>

<%
	String mId = request.getParameter("mId");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		conn = DBUtil.getConnection();
		String sql = "SELECT * FROM member WHERE memberName = ? AND memberEmail = ?";
		
		if (name == null) {
			sql = "SELECT * FROM member WHERE memberId = ? AND memberEmail = ?";
		}
		
		pstmt = conn.prepareStatement(sql);
		
		if (name == null) {
			pstmt.setString(1, mId);
		}else{
			pstmt.setString(1, name);
		}
		
		pstmt.setString(2, email);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			// 메일 발송 후 code 전달
			String code = "";
			for(int i = 0; i <= 5; i++){
				code += (int)(Math.random() * 10);
			}
			
			EmailAuthenticator auth = new EmailAuthenticator();
			
			// 메일 발송을 위한 메일 서버와 연결된 정보를 저장하는 객체
			Session ses = Session.getDefaultInstance(auth.getProp(), auth);
			
			// 메일 발송에 필요한 필수 정보
			MimeMessage msg = new MimeMessage(ses);
			// 받는사람, 참조, 숨은 참조
			// TO     CC    BCC
			// 이메일 어드레스를 저장하는 객체
			InternetAddress to = new InternetAddress(email);
			msg.setRecipient(MimeMessage.RecipientType.TO, to);
			// 발신자 지정
			InternetAddress from = new InternetAddress("master@baskinrobbins.com","MASTER");
			msg.setFrom(from);
			// 제목 지정
			msg.setSubject("BASKINROBBINS 31.2 인증코드", "UTF-8");
			String message = "<h3>인증코드 : ["+code+"]</h3>";
			message += "인증코드를 입력해주세요."; 
			msg.setContent(message,"text/html;charset=utf-8");
			
			// 발송
			Transport.send(msg);
			session.setAttribute("emailAddr", email);
            session.setAttribute("emailCode", code);
			// 정상 발신
			// out.println(code);
			response.getWriter().write(code);
		}else{
			out.print(false);
		}
	} catch (Exception e) {
		e.printStackTrace();
		// 발송 실패
		out.print(false);
	} finally{
		DBUtil.close(rs,pstmt,conn);
	}
%>