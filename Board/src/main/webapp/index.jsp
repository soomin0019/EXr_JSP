<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.WriteDAO" %>
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
  <div class="container">
    <div class="row">
      <a href="writeBoard.jsp" class="btn btn-primary pull-right" style="margin-bottom: 20px">글쓰기</a>
      <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
        <thead>
          <tr>
            <th style="background-color: #eeeeee; text-align: center;">번호</th>
            <th style="background-color: #eeeeee; text-align: center;">제목</th>
            <th style="background-color: #eeeeee; text-align: center;">작성자</th>
            <th style="background-color: #eeeeee; text-align: center;">작성일</th>
          </tr>
        </thead>
        <tbody>
          <tr>

          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</body>
</html>