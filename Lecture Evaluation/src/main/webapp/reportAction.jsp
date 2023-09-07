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
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String reportTitle = null;
    String reportContent = null;
    if(request.getParameter("reportTitle") != null ){   //사용자로부터 신고제목을 잘 받았다면
        reportTitle = request.getParameter("reportTitle");
    }
    if(request.getParameter("reportContent") != null ){   //사용자로부터 신고내용을 잘 받았다면
        reportContent = request.getParameter("reportContent");
    }
    if(reportTitle == null || reportContent == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


    //내용을 잘 입력해서 신고 버튼을 잘 눌렀다면
    String host = "http://localhost:8080/";
    String from = "smlee010998@gmail.com";
    String to = "smlee010998@gmail.com";    //신고되었다는 메일이 가는 주소
    String subject = "강의평가 사이트에서 접수된 신고 메일입니다";
    String content = "신고자 :" + userID +
            "<br> 제목 : " + reportTitle +
            "<br> 내용 : " + reportContent;
    //사용자가 링크를 눌러 이메일 인증 시도 가능

    //실제 이메일 전송하는 구성
    Properties p = new Properties();
    p.put("mail.smtp.user", from);                       //구글 이메일 계정
    p.put("mail.smtp.host", "smtp.googlemail.com");    //구글에서 제공하는 smtp서버
    p.put("mail.smtp.port", "465");                     //포트
    p.put("mail.smtp.starttls.enable", "true");         //starttls 사용가능
    p.put("mail.smtp.auth", "true");                    //stmp인증
    p.put("mail.smtp.debug", "true");                   //디버그 true
    p.put("mail.smtp.socketFactory.port", "465");       //smtp 소켓 팩토리 포트, 설마 여기가,,,아님
    p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   //'' 클래스 지정
    p.put("mail.smtp.socketFactory.fallback", "false");   //fallback


    //실제 신고메일을 전송하는 기능
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
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('정상적으로 신고되었습니다.');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    /*return;*/

%>
