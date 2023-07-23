<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Welcome to Quiz Website</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f7f7f7;
      text-align: center;
      margin: 50px;
    }
    h1 {
      color: #333333;
    }
  </style>
</head>
<body>
<h1>Welcome to Quiz Website</h1>
<%
  // Fetch the "current_active" attribute from the session
  Integer currentActiveUserId = (Integer) session.getAttribute("current_active");

  // Assuming you have a method in the UsersInformation class to get the username by user ID
  User user = null;
  try {
    user = UsersInformation.findUserById(currentActiveUserId.intValue());
  } catch (SQLException e) {
    throw new RuntimeException(e);
  }
  assert user != null;
  String username = user.getUsername();
%>
<h2>Welcome, <%= username %>!</h2>
<p>Start taking quizzes and enjoy the challenge!</p>
</body>
</html>