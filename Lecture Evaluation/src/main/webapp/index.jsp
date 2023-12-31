<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%--사용자가 어떤 게시물을 검색하는지--%>

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

  <%
    request.setCharacterEncoding("UTF-8");
    String lectureDivide = "전체";    //사용자가 검색한 강의 구분
    String searchType = "최신순";      // ``          검색 종류
    String search = "";               //  ``         검색어
    int pageNumber = 0;
    if(request.getParameter("lectureDivide") != null) {
      lectureDivide = request.getParameter("lectureDivide");
    }
    if(request.getParameter("searchType") != null) {
      searchType = request.getParameter("searchType");
    }
    if(request.getParameter("search") != null) {
      search = request.getParameter("search");
    }
    if(request.getParameter("pageNumber") != null) {
      try {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
      } catch (Exception e) {
        System.out.println("검색 페이지 오류");
      }
    }

    String userID = null;
    if(session.getAttribute("userID") != null) {
      userID = (String) session.getAttribute("userID");
    }
    if(userID == null) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('로그인을 해주세용.');");
      script.println("location.href = 'userLogin.jsp';");
      script.println("</script>");
      script.close();
      return;
    }

    boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
    //이메일 인증이 안 된 사용자에게 인증을 할 수 있도록
    if(emailChecked == false) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("location.href = 'emailSendConfirm.jsp';");
      script.println("</script>");
      script.close();
      return;
    }
  %>

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

            <%
              if (userID == null) {
            %>
            <a class="dropdown-item" href="userLogin.jsp">로그인</a>
            <a class="dropdown-item" href="userJoin.jsp">회원가입</a>
            <%
              } else {
            %>
            <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
            <%
              }
            %>

          </div>
        </li>
      </ul>
      <!--검색창 기능-->
      <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
        <input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-label="Search">
        <%--검색어를 입력했을 때 특정한 검색 url로 이동--%>
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
        <option value="전공" <% if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
        <option value="교양" <% if(lectureDivide.equals("교양")) out.println("selected"); %>>교양</option>
        <option value="기타" <% if(lectureDivide.equals("기타")) out.println("selected"); %>>기타</option>
      </select>
      <select name="searchType" class="form-control mx-1 mt-2">
        <option value="최신순">최신순</option> <!--옵션을 이용해 어떤 데이터를 보낼 것인지 분류-->
        <option value="추천순"><% if(searchType.equals("추천순")) out.println("selected");%>추천순</option>
      </select>
      <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요."/>
      <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
      <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
      <!--부트스트랩에서는 모달이라는 웹 페이지 위쪽에 등록양식처럼 생겼대-->
      <a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고하기</a>
    </form>

    <%--사용자가 검색한 내용이 리스트에 담겨서 출력되도록--%>
    <%
      ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
      evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
      if(evaluationList != null) {
        for (int i = 0; i < evaluationList.size(); i++) {
          if(i == 5) break;   //페이지 안 6개 중 5개까지만 출력되도록
          EvaluationDTO evaluation = evaluationList.get(i);

    %>

    <!--카드 등록/ 실제 사용자가 강의를 등록했을 때 어떻게 사용될지의 기능-->
    <div class="card bg-light mt-3">
      <div class="card-header bg-light">
        <div class="row">
          <div class="col-8 text-left"><%= evaluation.getLectureName()%>&nbsp;<small><%= evaluation.getProfessorName()%></small></div>
          <div class="col-4 text-right">
            종합<span style="color: red;"><%= evaluation.getTotalScore()%></span>
          </div>
        </div>
      </div>
      <!--강의명 밑 내용과 추천-->
      <div class="card-body">
        <h5 class="card-title">
          <%= evaluation.getEvaluationTitle()%>&nbsp;<small>(<%= evaluation.getLectureYear()%>)년 <%= evaluation.getSemesterDivide()%></small>
        </h5>
        <p class="card-text"><%= evaluation.getEvaluationContent()%></p>
        <div class="row">
          <div class="col-9 text-left">
            성적<span style="color: red;"><%= evaluation.getCreditScore()%></span>
            널널<span style="color: red;"><%= evaluation.getComfortableScore()%></span>
            강의<span style="color: red;"><%= evaluation.getLectureScore()%></span>
            <span style="color: green;">(추천:<%= evaluation.getLikeCount()%>)</span>
          </div>
          <!--강의 추천하는지 오른쪽 아래 위치-->
          <div class="col-3 text-right">
            <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
            <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
          </div>
        </div>
      </div>
    </div>
    <%
        }
      }
    %>

  </section>

  <%--페이지네이션--%>
  <ul class="pagination justify-content-center mt-3">
    <li class="page-item">
      <%
        if(pageNumber <= 0) {   //이 경우엔 페이지를 이동할 필요가 없으므로
      %>
      <a class="page-link disabled">이전</a>
      <%
        } else {
      %>
      <a class="page-link" href="./index.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide,"UTF-8")%>
      &searchType=<%=URLEncoder.encode(searchType,"UTF-8")%>&search=<%=URLEncoder.encode(search,"UTF-8")%>
      &pageNumber=<%=pageNumber - 1%>">이전</a>
      <%
        }
      %>
    </li>
    <li class="page-item">
      <%
        if(evaluationList.size() < 6) {   /*이 경우엔 뒤(페이지)로 갈 수 없으므로*/
      %>
      <a class="page-link disabled">다음</a>
      <%
      } else {
      %>
      <a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8")%>&searchType=
        <%= URLEncoder.encode(searchType, "UTF-8")%>&search=<%= URLEncoder.encode(search, "UTF-8")%>
        &pageNumber=<%= pageNumber + 1 %>">다음</a>
      <%
        }
      %>
    </li>
  </ul>
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
                <input type="text" name="lectureName" class="form-control" maxlength="20">
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
                <select name="lectureDivide" class="form-control">
                  <option value="전공" selected>전공</option>
                  <option value="교양">교양</option>
                  <option value="기타">기타</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label>제목</label>
              <input type="text" name="evaluationTitle" class="form-control" maxlength="30">
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