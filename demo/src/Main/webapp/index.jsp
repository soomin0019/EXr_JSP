<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>우리의 첫 번째 페이지</title>
</head>
<body>
    <form action="./userJoinAction.jsp" method = "post">
        <input type="text" name = "userID">
        <input type="password" name="userPassword">
        <input type="submit" value="회원가입">
    </form>
</body>
</html>