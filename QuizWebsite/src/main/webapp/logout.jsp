<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Clear session data and update 'current_active' to null
  session.setAttribute("current_active", null);

  // Redirect back to the login page or any other desired page
  response.sendRedirect("login");
%>
