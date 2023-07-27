<%@ page import="com.freeuni.quizwebsite.service.manipulation.FriendRequestManipulation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    FriendRequestManipulation.deleteFriendRequestByIds(Integer.parseInt(request.getParameter("user_id")),
            (Integer) session.getAttribute("current_active"));

    response.sendRedirect("home_page.jsp");
%>