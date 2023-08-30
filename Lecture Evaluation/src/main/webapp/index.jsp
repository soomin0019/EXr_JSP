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
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp">메인</a>
        </li>
        <li class="nav-item dropdown"><!--한 번 눌렀을 때 아래로 목록 정렬-->
          <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원관리</a>
          <div class="dropdown-menu" aria-labelledby="dropdown">
            <a class="dropdown-item" href="userLogin.jsp">로그인</a>
            <a class="dropdown-item" href="userJoin.jsp">회원가입</a>
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
  <section class="container">
    <form method="get" action="./index.jsp" class="form-inline mt-3">
      <!--get 방식으로 사용자에게서 데이터 받아와 서버로 전달 => 검색창 -->
      <select name="LectureDivide" class="form-control mx-1 mt-2">
        <option value="전체">전체</option> <!--옵션을 이용해 어떤 데이터를 보낼 것인지 분류-->
        <option value="전공">전공</option>
        <option value="교양">교양</option>
        <option value="기타">기타</option>
      </select>
      <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요">
      <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
      <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
      <!--부트스트랩에서는 모달이라는 웹 페이지 위쪽에 등록양식처럼 생겼대-->
      <a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고하기</a>
    </form>
    <!--카드 등록/ 실제 사용자가 강의를 등록했을 때 어떻게 사용될지의 기능-->
    <div class="card bg-light mt-3">
      <div class="card-header bg-light">
        <div class="row">
          <div class="col-8 text-left">컴퓨터개론&nbsp;<small>나동빈</small></div>
          <div class="col-4 text-right">
            종합<span style="color: red;">A</span>
          </div>
        </div>
      </div>
      <!--강의명 밑 내용과 추천-->
      <div class="card-body">
        <h5 class="card-title">
          정말 좋은 강의에오&nbsp;<small>(2022년 가을학기)</small>
        </h5>
        <p class="card-text">강의가 널널하고 학점이 잘 나와요</p>
        <div class="row">
          <div class="col-9 text-left">
            성적<span style="color: red;">A</span>
            널널<span style="color: red;">A</span>
            강의<span style="color: red;">B</span>
            <span style="color: green;">(추천:15명)</span>
          </div>
          <!--강의 추천하는지 오른쪽 아래 위치-->
          <div class="col-3 text-right">
            <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
            <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
          </div>
        </div>
      </div>
    </div>
    <!--카드 등록/ 실제 사용자가 강의를 등록했을 때 어떻게 사용될지의 기능-->
    <div class="card bg-light mt-3">
      <div class="card-header bg-light">
        <div class="row">
          <div class="col-8 text-left">컴퓨터개론&nbsp;<small>나동빈</small></div>
          <div class="col-4 text-right">
            종합<span style="color: red;">A</span>
          </div>
        </div>
      </div>
      <!--강의명 밑 내용과 추천-->
      <div class="card-body">
        <h5 class="card-title">
          괜춘&nbsp;<small>(2022년 가을학기)</small>
        </h5>
        <p class="card-text">학점 잘 나와요</p>
        <div class="row">
          <div class="col-9 text-left">
            성적<span style="color: red;">A</span>
            널널<span style="color: red;">A</span>
            강의<span style="color: red;">B</span>
            <span style="color: green;">(추천:15명)</span>
          </div>
          <!--강의 추천하는지 오른쪽 아래 위치-->
          <div class="col-3 text-right">
            <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
            <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
          </div>
        </div>
      </div>
    </div>

    <!--카드 등록/ 실제 사용자가 강의를 등록했을 때 어떻게 사용될지의 기능-->
    <div class="card bg-light mt-3">
      <div class="card-header bg-light">
        <div class="row">
          <div class="col-8 text-left">컴퓨터개론&nbsp;<small>나동빈</small></div>
          <div class="col-4 text-right">
            종합<span style="color: red;">A</span>
          </div>
        </div>
      </div>
      <!--강의명 밑 내용과 추천-->
      <div class="card-body">
        <h5 class="card-title">
          정말 좋은 강의에오&nbsp;<small>(2022년 가을학기)</small>
        </h5>
        <p class="card-text">강의가 널널하고 학점이 잘 나와요</p>
        <div class="row">
          <div class="col-9 text-left">
            성적<span style="color: red;">A</span>
            널널<span style="color: red;">A</span>
            강의<span style="color: red;">B</span>
            <span style="color: green;">(추천:15명)</span>
          </div>
          <!--강의 추천하는지 오른쪽 아래 위치-->
          <div class="col-3 text-right">
            <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
            <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
          </div>
        </div>
      </div>
    </div>

  </section>

  <!--모달 양식, 등록하기 버튼을 눌렀을 때 반응 기능-->
  <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content"> <!--모달 안에 들어가 있는 내용 정의-->
        <div class="modal-header">
          <h5 class="modal-title" id="modal">평가 등록</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><!--모달 창을 닫도록-->
            <span aria-hidden="true">&times;</span><!--닫기 아이콘-->
          </button>
        </div>
        <div class="modal-body">
          <form action="./evaluationRegisterAction.jsp" method="post">
            <div class="form-row">
              <div class="form-group col-sm-6">
                <label>강의명</label>
                <input type="text" name="LectureName" class="form-control" maxlength="20">
              </div>
              <div class="form-group col-sm-6">
                <label>교수명</label>
                <input type="text" name="professorName" class="form-control" maxlength="20">
              </div>
            </div>
            <div class="form-row"><!--가로로 배치-->
              <div class="form-group col-sm-4"><!--한 개의 행 중에 4개만큼 차지-->
                <label>수강연도</label>
                <select name="lectureYear" class="form-control">
                  <option value="2015">2015</option>
                  <option value="2016">2016</option>
                  <option value="2017">2017</option>
                  <option value="2018">2018</option>
                  <option value="2019">2019</option>
                  <option value="2020">2020</option>
                  <option value="2021">2021</option>
                  <option value="2022">2022</option>
                  <option value="2023" selected>2023</option><!--디폴트-->
                  <option value="2024">2024</option>
                  <option value="2025">2025</option>
                  <option value="2026">2026</option>
                </select>
              </div>
              <div class="form-group col-sm-4">
                <label>수강 학기</label>
                <select name="semesterDivide" class="form-control">
                  <option value="1학기" selected>1학기</option>
                  <option value="여름학기">여름학기</option>
                  <option value="2학기">2학기</option>
                  <option value="겨울학기">겨울학기</option>
                </select>
              </div>
              <div class="form-group col-sm-4">
                <label>강의 구분</label>
                <select name="semesterDivide" class="form-control">
                  <option value="전공" selected>전공</option>
                  <option value="교양">교양</option>
                  <option value="기타">기타</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label>제목</label>
              <input type="text" name="evaluation" class="form-control" maxlength="30">
            </div>
            <div class="form-group">
              <label>내용</label>
              <textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px">
                <%--textarea는 기본 타입이 텍스트이므로 타입을 지정해주지 않는다--%>
              </textarea>
            </div>
            <div class="form-row">
              <div class="form-group col-sm-3">
                <label>총합</label>
                <select name="totalScore" class="form-control">
                  <option value="A" selected>A</option>
                  <option value="B">B</option>
                  <option value="C">C</option>
                  <option value="D">D</option>
                  <option value="F">F</option>
                </select>
              </div>
              <div class="form-group col-sm-3">
                <label>성적</label>
                <select name="creditScore" class="form-control">
                  <option value="A" selected>A</option>
                  <option value="B">B</option>
                  <option value="C">C</option>
                  <option value="D">D</option>
                  <option value="F">F</option>
                </select>
              </div>
              <div class="form-group col-sm-3">
                <label>널널</label>
                <select name="comfortableScore" class="form-control">
                  <option value="A" selected>A</option>
                  <option value="B">B</option>
                  <option value="C">C</option>
                  <option value="D">D</option>
                  <option value="F">F</option>
                </select>
              </div>
              <div class="form-group col-sm-3">
                <label>강의</label>
                <select name="lectureScore" class="form-control">
                  <option value="A" selected>A</option>
                  <option value="B">B</option>
                  <option value="C">C</option>
                  <option value="D">D</option>
                  <option value="F">F</option>
                </select>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
              <button type="submit" class="btn btn-primary">등록하기</button>
            </div>
            <!--실제 registoer 부분을 등록하지 않았기 때문에 오류 발생할 수 있음-->
          </form>
        </div>
      </div>
    </div>
  </div>
  <!--신고하기 버튼을 눌렀을 때 나타나는 기능-->
  <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content"> <!--모달 안에 들어가 있는 내용 정의-->
        <div class="modal-header">
          <h5 class="modal-title" id="modal">신고하기</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><!--모달 창을 닫도록-->
            <span aria-hidden="true">&times;</span><!--닫기 아이콘-->
          </button>
        </div>
        <div class="modal-body">
          <form action="./reportAction.jsp" method="post">
            <div class="form-group">
              <label>신고 제목</label>
              <input type="text" name="reportTitle" class="form-control" maxlength="30">
            </div>
            <div class="form-group">
              <label>신고 내용</label>
              <textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px">
                <%--textarea는 기본 타입이 텍스트이므로 타입을 지정해주지 않는다--%>
              </textarea>
            </div>
            <div class="form-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
              <button type="submit" class="btn btn-danger">신고하기</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
    Copyright&copy; 2022나동빈  All Rights Reserved
  </footer>
  <!--제이쿼리, 파퍼, 부트스트랩 자바스크립트 추가-->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>

</body>


</html>