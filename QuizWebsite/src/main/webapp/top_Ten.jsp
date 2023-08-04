<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Quiz" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Top Ten Quizzes</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5; /* Light gray background */
      margin: 0;
      padding: 0;
      color: #333333;
    }
    /* Container for quizzes */
    .quizzes-container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
    }

    /* Style for each quiz item */
    .quiz-item {
      margin-bottom: 20px;
      padding: 20px;
      border: 1px solid #cccccc;
      background-color: #ffffff; /* White background */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      position: relative; /* To accommodate the animation */
    }

    .quiz-item a {
      text-decoration: none;
      font-weight: bold;
    }

    .quiz-item a:hover {
      text-decoration: underline;
    }

    /* Rank label styles */
    .rank-label {
      font-size: 20px;
      font-weight: bold;
    }

    .rank-label.green {
      color: #008000;
    }

    .rank-label.blue {
      color: #0000FF;
    }

    /* Home button style */
    .home-button {
      background-color: #007bff;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      margin-top: 20px;
    }

    .home-button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="quizzes-container">
  <h1 style="text-align: center; margin-bottom: 30px;">Top Ten Quizzes</h1>
  <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
  <br>
  <br>
  <br>
  <% List<Quiz> topQuizzes;
    try {
      topQuizzes = QuizzesInformation.getPublicQuizzesOrderedByViews();
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
    if (topQuizzes.isEmpty()) { %>
  <p>There are no quizzes available right now.</p>
  <% } else {
    int i=1;
    for (Quiz quiz : topQuizzes) {
      if (i > 10) break;
  %>
  <div class="quiz-item">
    <p class="rank-label <%= i <= 3 ? "green" : "blue" %>">#<%=i%></p>
    <a href="quiz?id=<%=quiz.getQuizId()%>" style="color: <%= i <= 3 ? "#008000" : "#0000FF" %>;">
      <%=quiz.getName() %>
    </a>
    <p>Views: <%=quiz.getViewCount()%></p>
  </div>
  <% i++;
  }
  }
  %>
</div>
<script>
  function redirectTo(url) {
    window.location.href = url;
  }
</script>
</body>
</html>
