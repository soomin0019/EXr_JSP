<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-01
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>

<%--회원가입에 성공한 사람이 로그인 할 때 요청을 처리해주는 액션 페이지--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>    <%--특정한 스크립트 구문 출력할 때 사용--%>

<%
    session.invalidate();
%>
<script>
    location.href = 'index.jsp';
</script>

