<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-08-28
  Time: 오후 8:01
  To change this template use File | Settings | File Templates.
--%>
<!-- 페이지의 속성을 지정하는 JSP 지시문 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<!-- 스크립트릿 : JSP에서 Java 코드를 실행하거나 처리하는 영역 -->
<%
    //요청 파라미터의 문자 인코딩을 UTF-8로 설정: 사용자가 입력한 데이터를 제대로 처리하기 위해 인코딩을 맞추는 작업
    request.setCharacterEncoding("UTF-8");

    //userID, userPassword 변수를 선언하여 사용자가 입력한 값을 저장할 객체를 생성
    String userID = null;
    String userPassword = null;

    //사용자가 입력한 값이 null이 아니라면 변수에 저장한다.
    if(request.getParameter("userID") != null) {
        userID = (String) request.getParameter("userID");
    }
    if(request.getParameter("userPassword") != null) {
        userPassword = (String) request.getParameter("userPassword");
    }

    //만약 둘 중 하나라도 null이라면, JavaScript로 경고창을 띄우고 이전페이지로 이동하는 스크립트를 출력한다.
    if(userID == null || userPassword == null) {
        //Java에서 웹으로 데이터를 출력할 때 PrintWriter를 사용한다.
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 사항이 있습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }


    //UserDAO 객체를 생성 -> 'join 메서드를 호출 -> 회원가입 처리 시도.
    UserDAO userDAO = new UserDAO();
    //'result' 변수에는 join 메서드의 반환값이 저장된다. <= pstmt.executeUpdate(); (쿼리를 실행하고 업데이트된 레코드 수)
    int result = userDAO.join(userID, userPassword);

    if(result == 1) {
        //JavaScript로 메시지와 페이지 이동을 처리하는 스크립트를 출력
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 성공했습니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
    }
%>

