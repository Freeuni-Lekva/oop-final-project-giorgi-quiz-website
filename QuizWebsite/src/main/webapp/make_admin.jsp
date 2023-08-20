<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.freeuni.quizwebsite.service.manipulation.UsersManipulation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("current_active") == null) {
        request.setAttribute("not-logged", new Object());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    int userId = Integer.parseInt(request.getParameter("user_id"));

    User user = null;
    try {
        user = UsersInformation.findUserById(userId);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    boolean is_admin = false;
    if (user != null) {
        try {
            UsersManipulation.makeUserAdmin(userId);
            is_admin = true;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    response.sendRedirect(request.getHeader("Referer"));
%>