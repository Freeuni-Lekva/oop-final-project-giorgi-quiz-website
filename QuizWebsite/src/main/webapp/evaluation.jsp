<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 8/13/2023
  Time: 4:27 PM
  To change this template use File | Settings | File Templates.
--%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Quiz Website - Evaluation</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5; /* Light gray background */
      margin: 0;
      padding: 0;
      color: #333333;
    }

    /* Container for evaluation */
    .evaluation-container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
    }
    @keyframes fadeInZoom {
      0% {
        opacity: 0;
        transform: scale(0.9);
      }
      100% {
        opacity: 1;
        transform: scale(1);
      }
    }
    /* Style for score display item */
    .score-item {
      margin-bottom: 20px;
      padding: 20px;
      border: 1px solid #cccccc;
      background-color: #ffffff; /* White background */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      position: relative; /* To accommodate the animation */
      animation: fadeInZoom 1s forwards;
    }

    .score-item:hover {
      transform: translateY(-5px); /* Add a slight lift on hover */
      transition: transform 0.2s ease; /* Smooth animation */
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

    /* Styling for score */
    .score {
      color: #007bff;
      font-size: 24px;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="evaluation-container">
  <h1 style="text-align: center; margin-bottom: 30px;">Evaluation</h1>
  <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
  <p></p>

  <% // Assuming that the score is passed as an attribute named "score"
    Integer score = (Integer) request.getAttribute("score");
    if (score != null) {
  %>
  <div class="score-item">
    <p class="score">Your Score: <%= score %></p>
  </div>
  <% } else { %>
  <p style="text-align: center; margin-top: 50px; font-size: 18px; color: #888;">No score available at the moment.</p>
  <% } %>
</div>
<script>
  function redirectTo(url) {
    window.location.href = url;
  }
</script>
</body>
</html>
