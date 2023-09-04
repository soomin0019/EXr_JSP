<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-01
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.Gmail" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="util.SHA256" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%-- //특정한 스크립트 구문 출력할 때 사용--%>

<%
    UserDAO userDAO = new UserDAO();
    String userID = null;
    if(session.getAttribute("userID") != null){
        //사용자가 로그인한 상태, 세션 값이 유효한 상태
        userID = (String) session.getAttribute("userID");
    }
    if(userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
    }

    boolean emailChecked = userDAO.getUserEmailChecked(userID);
    //이메일 인증이 되었는지 확인
    if(emailChecked == true){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 인증된 회원입니다.');");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    //이메일 인증 메세지를 보내줌
    String host = "http://localhost:8080/";
    String from = "smlee010998@gmail.com";
    String to = userDAO.getUserEmail(userID);
    String subject = "강의평가를 위한 이메일 인증입니다";
    String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." +
            "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
    //사용자가 링크를 눌러 이메일 인증 시도 가능

    //실제 이메일 전송하는 구성
    Properties p = new Properties();
    p.put("mail.smpt.user", from);                       //구글 이메일 계정
    p.put("mail.smtp.host", "smtp.googlemail.com");    //구글에서 제공하는 smtp서버
    p.put("mail.smtp.port", "456");                     //포트
    p.put("mail.smtp.starttls.enable", "true");         //starttls 사용가능
    p.put("mail.smtp.auth", "true");                    //stmp인증
    p.put("mail.smtp.debug", "true");                   //디버그 true
    p.put("mail.smtp.socketFactory.port", "465");       //smtp 소켓 팩토리 포트, 설마 여기가,,,아님
    p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   //'' 클래스 지정
    p.put("mail.smtp.socketFactory.fallback", "false");     //fallback


    //실제 이메일을 전송하는 기능
    try{
        //실제로 gmail인증을 수행해 사용자에게 관리자의 메일주소로 메일 전송
        Authenticator auth = new Gmail();
        Session ses = Session.getInstance(p, auth);
        ses.setDebug(true);             //디버깅 설정
        MimeMessage msg = new MimeMessage(ses);  //MimeMesssage 객체로 실제로 메일을 보낼 수 있게 함메일 제목
        msg.setSubject(subject);        //메일 제목
        Address fromAddr = new InternetAddress(from);  //보내는 사람 정보
        msg.setFrom(fromAddr);
        Address toAddr = new InternetAddress(to);   //받는 사람 정보
        msg.addRecipient(Message.RecipientType.TO, toAddr);
        msg.setContent(content, "text/html;charset=UTF8");
        Transport.send(msg);        //안정적으로 메일 전송

    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생했습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

%>

<%--이메일을 보냈다는 메세지 출력--%>
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
                        <%
                            if(userID == null) {
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
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-2" type="submit">검색</button>
            </form>
        </div>
    </nav>
    <!--본문이 들어가는 공간-->
    <section class="container mt-3" style="max-width: 560px">
        <div class = "alert alert-success mt-4" role="alert">
            이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가서 인증해주세요
        </div>
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
