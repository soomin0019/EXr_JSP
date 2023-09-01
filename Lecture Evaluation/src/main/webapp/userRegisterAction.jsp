<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-01
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>    //특정한 스크립트 구문 출력할 때 사용

<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    String userPassword = null;
    String userEmail = null;

    if(request.getParameter("userID") != null){
        userID = request.getParameter("userID");
    }
    if(request.getParameter("userPassword") != null){
        userPassword = request.getParameter("userPassword");
    }
    if(request.getParameter("userEmail") != null){
        userEmail = request.getParameter("userEmail");
    }

    //사용자가 정상적으로 입력하지 않은 경우
    if(userID == null || userPassword == null || userEmail == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return; //오류가 발생한 경우 바로 JSP페이지 작동 종료
    }

    //실제 회원가입 정상적으로 진행
    UserDAO userDAO = new UserDAO();
    int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
    //회원가입 진행

    //회원가입이 등록이 성공적으로 되지 않았을 시
    if(result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 존재하는 아이디입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {    //성공적일 때
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'emailSendAction.jsp'");
        script.println("</script>");
        script.close();
        /*return;*/
    }
%>

