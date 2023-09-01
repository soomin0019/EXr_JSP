<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-09-01
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>

<%--회원가입에 성공한 사람이 로그인 할 때 요청을 처리해주는 액션 페이지--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>    <%--특정한 스크립트 구문 출력할 때 사용--%>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    String userPassword = null;

    if(request.getParameter("userID") != null){
        userID = request.getParameter("userID");
    }
    if(request.getParameter("userPassword") != null){
        userPassword = request.getParameter("userPassword");
    }

    //사용자가 정상적으로 입력하지 않은 경우
    if(userID == null || userPassword == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return; //오류가 발생한 경우 바로 JSP페이지 작동 종료
    }

    //실제 로그인 정상적으로 진행
    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(userID, userPassword);

    //로그인이 성공적으로 되었을 시
    if(result == 1){
        session.setAttribute("userID", userID);     //세션값 설정
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    } else if(result == 0){    //비밀번호가 틀렸을 때
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        /*return;*/
    } else if(result == -1){    //아이디가 틀렸을 때
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        /*return;*/
    } else if(result == -2){    //데이터베이스 오류
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        /*return;*/
    }
%>

