<%@ page import="com.freeuni.quizwebsite.model.db.Challenge" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quiz Website - Challenges</title>
    <!-- Add any CSS styles you need for the challenges page here -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9; /* Light green background */
            margin: 0;
            padding: 0;
            color: #333333;
        }

        /* Container for challenges */
        .challenges-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Style for each challenge item */
        .challenge-item {
            margin-bottom: 20px;
            padding: 20px;
            border: 1px solid #cccccc;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .challenge-item a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .challenge-item a:hover {
            text-decoration: underline;
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

        /* Complete button style */
        .complete-button {
            background-color: #66bb6a;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 10px;
        }

        .complete-button:hover {
            background-color: #4caf50;
        }
    </style>
</head>
<body>
<div class="challenges-container">
    <h1>Challenges</h1>
    <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
    <p></p>
    <%
        List<Challenge> challenges = (List<Challenge>) request.getAttribute("challenges");
        if (challenges.isEmpty()) {
    %>
    <p>No challenges at the moment.</p>
    <%
    } else {
        for (Challenge challenge : challenges) {
    %>
    <div class="challenge-item">
        <p><b>Sender User:</b> <a
                href="profile?user_id=<%= challenge.getSenderUserId() %>"><%= UsersInformation.findUserById(challenge.getSenderUserId()).getUsername() %>
        </a></p>
        <p><b>Quiz:</b> <a
                href="quiz?id=<%= challenge.getQuizId() %>"><%= QuizzesInformation.findQuizById(challenge.getQuizId()).getName() %>
        </a></p>
        <p><b>Description:</b> <%= challenge.getDescription() %>
        </p>
        <p><b>Send Time:</b> <%= challenge.getSendTime() %>
        </p>
        <button class="complete-button" onclick="redirectToQuiz('<%= challenge.getQuizId() %>')">Complete</button>
    </div>
    <%
            }
        }
    %>
</div>
<script>
    function redirectTo(url) {
        window.location.href = url;
    }

    function redirectToQuiz(quizId) {
        window.location.href = 'quiz?id=' + quizId;
    }
</script>
</body>
</html>
