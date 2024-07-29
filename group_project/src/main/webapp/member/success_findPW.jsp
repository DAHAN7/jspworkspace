<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, servlet.*" %>
<%
    String mId = request.getParameter("mId");
    String email = request.getParameter("email");
    String code = request.getParameter("code");
    String emailCode = (String) session.getAttribute("emailCode");  // 세션에 저장된 발송된 코드
    
    if (code.equals(emailCode)) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT count(*) FROM member WHERE memberId = ? AND memberEmail = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mId);
            pstmt.setString(2, email);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
%>
			<html>
			<head>
			<meta charset="UTF-8">
			<title>비밀번호찾기 - BASKINROBBINS 31.2</title>
			</head>
			<body>
				<form action="ResetPW.jsp" method="POST">
			        <div>
			            <div>
			                <p>새 비밀번호 설정</p>
			            </div>
			            <table>
			                <tr>
			                    <td>새 비밀번호</td>
			                    <td>
			                    	<input type="hidden" name="mId" value="<%= mId %>">
			                    	<input type="hidden" name="email" value="<%= email %>">
			                        <input type="password" name="newPw" id="pw1" onkeyup="checkPw()" required>
			                        <p id="pwMessage">영문/숫자/특수문자를 조합하여 10~16자로 입력해주세요.</p>
			                    </td>
			                </tr>
			                <tr>
			                    <td>새 비밀번호 확인</td>
			                    <td>
			                        <input type="password" name="newPwChk" id="pw2" onkeyup="checkPwMatch()" required>
			                        <p id="pwCheckMessage">비밀번호를 다시 한 번 입력해주세요.</p>
			                    </td>
			                </tr>
			            </table>
			            <div id="btnbox">
			                <input type="submit" id="check" value="확인">
			                <input type="button" id="remove" value="새로 입력" onclick="clearForm()">
			            </div>
			        </div>
			    </form>
			</body>
			</html>
<%
            } else {
%>
                <script>
                	alert('존재하지 않는 계정입니다.');
                	history.back(-1);
                </script>
<%
            }
        } catch (Exception e) {
            	e.printStackTrace();
        } finally {
            DBUtil.close(rs, pstmt, conn);
        }
    } else {
%>
		<script>
			alert('인증코드가 일치하지 않습니다.');
			history.back(-1);
		</script>
<%
    }
%>
<script>
	function clearForm() {
			document.getElementById("pw1").value = "";
			document.getElementById("pw2").value = "";
			document.getElementById("pwMessage").innerText = "영문/숫자/특수문자를 조합하여 10~16자로 입력해주세요.";
	        document.getElementById("pwCheckMessage").innerText = "비밀번호를 다시 한 번 입력해주세요.";
	        document.getElementById("pwMessage").style.color = ""; 		// Reset color
	        document.getElementById("pwCheckMessage").style.color = ""; // Reset color
	}
	
	function checkPw() {
		var newPw = document.getElementById("pw1").value;
		var message = document.getElementById("pwMessage");
		
		// 비밀번호 제한 조건
		var length = /^.{10,16}$/;
		var criteria = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@$!%*?&]).{10,16}$/;
		
		if (!length.test(newPw)) {
			message.innerText = "비밀번호는 10~16자까지 입력 가능합니다.";
			message.style.color = "#F58";
		} else if (!criteria.test(newPw)) {
			message.innerText = "영문/숫자/특수 문자 중 2가지 이상 조합하셔야 합니다.";
            message.style.color = "#F58";
		} else {
			message.innerText = "사용 가능한 비밀번호 입니다.";
            message.style.color = "skyblue";
		}	
	}
	
	function checkPwMatch() {
		var newPw = document.getElementById("pw1").value;
		var newPwChk = document.getElementById("pw2").value;
		var message = document.getElementById("pwCheckMessage");
		
		if (newPw === newPwChk) {
			message.innerText = "입력한 비밀번호가 일치합니다.";
			message.style.color = "skyblue";
		} else {
			message.innerText = "입력한 비밀번호가 서로 일치하지 않습니다.";
			message.style.color = "#F58";
		}
	}
	
	window.onload = function() {
		document.getElementById("pw1").addEventListener("input", checkPw);
		document.getElementById("pw2").addEventListener("input", checkPwMatch);
	}
</script>