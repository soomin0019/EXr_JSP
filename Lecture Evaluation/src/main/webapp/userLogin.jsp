<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!--반응형 웹, 화면을 볼 때 디자인 알아서 설정-->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>강의평가 웹 사이트</title>
  <!--부트스트랩, 커스텀 CSS-->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
      <!--data-target : navbar 아이디를 가진 요소가 보였다 보이지 않았다가 한다-->
      <span class="navbar-toggler-icon"></span> <!--짝대기 3개가 그어져 있는 아이콘-->
    </button>
    <!--버튼 눌렀을 때 실행되는 부분(화면인 길 때 옆으로 보이고 좁으면 토글로 열도록-->
    <div id="navbar" class="collapse navbar-collapse">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">메인</a>
        </li>
        <li class="nav-item dropdown"><!--한 번 눌렀을 때 아래로 목록 정렬-->
          <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원관리</a>
          <div class="dropdown-menu" aria-labelledby="dropdown">
            <a class="dropdown-item" href="userLogin.jsp">로그인</a>
            <a class="dropdown-item active" href="userJoin.jsp">회원가입</a>
            <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
          </div>
        </li>
      </ul>
      <!--검색창 기능-->
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-label="Search">
        <button class="btn btn-outline-success my-2 my-sm-2" type="submit">검색</button>
      </form>
    </div>
  </nav>
  <!--본문이 들어가는 공간-->
  <section class="container mt-3" style="max-width: 560px">
    <form method="post" action="./userLoginAction.jsp">
      <div class="form-group">
        <label>아이디</label>
        <input type="text" name="userID" class="form-control">
      </div>
      <div class="form-group">
        <label>비밀번호</label>
        <input type="password" name="userPassword" class="form-control">
      </div>
      <button type="submit" class="btn btn-primary">로그인</button>
    </form>


  </section>

  <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
    Copyright&copy; 2022나동빈  All Rights Reserved
  </footer>
  <!--제이쿼리, 파퍼, 부트스트랩 자바스크립트 추가-->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>

</body>


</html>