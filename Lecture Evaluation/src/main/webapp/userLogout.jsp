<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-01
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>

<%--로그아웃을 요청할 때 처리해주는 페이지--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<%
    session.invalidate();   //현재 사용자가 모든 클라이언트의 세션 정보 파기
%>

<script>
    location.href = 'index.jsp';
</script>