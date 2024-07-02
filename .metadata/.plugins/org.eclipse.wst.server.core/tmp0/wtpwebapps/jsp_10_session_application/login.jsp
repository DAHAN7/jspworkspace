    <%@ page language="java" contentType="text/html; charset=UTF-8" %>
    <!-- login.jsp -->
    <%@ include file="common/header.jsp" %>
    <form action="loginCheck.jsp" method="POST">
        <table>
            <tr>
                <th colspan="2">
                    <h3>LOGIN PAGE</h3>
                </th>
            </tr>
            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" name="uid" required autocomplete="off"/>
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" name="upw" required/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <label>
                        <input type="checkbox" name="rememberMe" />
                    </label>
                </td>
            </tr>
            <tr>
                <th colspan="2"></th>
            </tr>
        </table>
    </form>
    <%@ include file="common/tail.jsp" %>

















