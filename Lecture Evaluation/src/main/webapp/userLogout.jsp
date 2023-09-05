<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-01
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>

<<<<<<< HEAD
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

=======
<%--로그아웃을 요청할 때 처리해주는 페이지--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<%
    session.invalidate();   //현재 사용자가 모든 클라이언트의 세션 정보 파기
%>

<script>
    location.href = 'index.jsp';
</script>
>>>>>>> 79ed31e45e6b3c54174ccb42c8550d43c8ff2784
