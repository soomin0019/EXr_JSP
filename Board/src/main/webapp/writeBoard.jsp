<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판 사이트</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
    <div>
        <a href="index.jsp" style="pointer-events: none; color: black;">
            <h1 style="margin-left: 50px; padding: 50px">JSP 게시판</h1></a>
    </div>
    <div class="container" style="">
        <table>
            <tr>
                <th>제목</th>
                <th><input type="text" name="title" style="width: 300px"></th>
            </tr>
            <tr>
                <td>이름</td>
                <td><input type="text" name="name" style="width: 300px"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><input type="text" name="content" style="width: 300px; height: 500px"></td>
            </tr>
        </table>
        <input type="submit" value="글 올리기" onclick="location.href='index.jsp'">
        <input type="submit" value="취소" onclick="location.href='index.jsp'">
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>