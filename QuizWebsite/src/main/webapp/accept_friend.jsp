<%@ page import="com.freeuni.quizwebsite.service.manipulation.FriendsManipulation" %>
<%@ page import="com.freeuni.quizwebsite.service.manipulation.FriendRequestManipulation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("current_active") == null){
        throw new RuntimeException();
    }
    FriendsManipulation.addFriendByIds(Integer.parseInt(request.getParameter("user_id")),
            (Integer) session.getAttribute("current_active"));
    FriendRequestManipulation.deleteFriendRequestByIds(Integer.parseInt(request.getParameter("user_id")),
            (Integer) session.getAttribute("current_active"));

    response.sendRedirect( request.getHeader("Referer") );
%>