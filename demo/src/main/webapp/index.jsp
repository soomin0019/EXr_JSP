<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
    Hello World!
    <form action="./userJoinAction.jsp" method="post">
        <input type="text" name="userID">
        <input type="pass" name="userPassword">
        <input type="submit" name="회원가입">
    </form>
</body>
</html>