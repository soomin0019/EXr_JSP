<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-01
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>    <%--//특정한 스크립트 구문 출력할 때 사용--%>

<%
    request.setCharacterEncoding("UTF-8");
    String code = null;
    if(request.getAttribute("code") != null){ //현재 아이디로 로그인이 되어있는지 확인
        code = request.getParameter("code");   //sesstion값은 기본적으로 object값을 반환
    }

    UserDAO userDAO = new UserDAO();
    String userID = null;
    if(request.getAttribute("userID") != null){ //현재 아이디로 로그인이 되어있는지 확인
        userID = (String) request.getParameter("userID");   //sesstion값은 기본적으로 object값을 반환
    }

    if(userID == null ){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.');");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
        return; //오류가 발생한 경우 바로 JSP페이지 작동 종료
    }

    //현재 사용자의 이메일 주소를 받아옴
    String userEmail = userDAO.getUserEmail(userID);
    //hash값을 적용한 사용자 이메일을 가져와 일치하는지 확인
    boolean isRight = (new SHA256().getSHA256(userEmail).equals(code))? true : false;

    //사용자가 보낸 코드가 정상적(true)이라면 메세지 출력
    if (isRight == true) {
        userDAO.setUserEmailChecked(userID);    //실제 사용자의 이메일 인증 처리
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('인증에 성공했습니다.');");
        script.println("location.href = 'index.jsp'");  //메인 페이지로 돌려보내기
        script.println("</script>");
        script.close();
        return;
   } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 코드입니다.');");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        /*return;*/
    }
%>

