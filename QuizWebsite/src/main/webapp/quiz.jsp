<%@ page import="com.freeuni.quizwebsite.model.db.Quiz" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.freeuni.quizwebsite.model.db.QuizHistory" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizHistoryInformation" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9; /* Light green background */
            margin: 0;
            padding: 0;
        }

        .friend-item img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
        }

        ♦.quiz-item p {
            font-size: 14px;
            color: #888888;
        }

        .friend-request-item .friend-name {
            flex: 1; /* Take up remaining space */
        }

        .friend-request-item .friend-buttons {
            display: flex;
            gap: 10px;
        }

        #header h1 {
            font-size: 32px;
            margin: 0;
            flex: 1;
        }


        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }



        #my-quizzes h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }


        #quizzes h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }


        #friends-list h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }

        .friend-item img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }


        #friend-requests h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }


        .friend-request-item img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        #admin-controls input[type="submit"] {
            background-color: dodgerblue;
            border-radius: 4px;
            padding: 8px 20px;
            margin-left: 10px;
        }

        #admin-controls input[type="text"] {
            font-size: 16px;
            margin-right: 10px;
            margin-left: 10px;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 0;
        }

        h1, h2, h3, h4, h5, h6 {
            color: #43a047;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        a {
            text-decoration: none;
            color: #43a047;
        }

        /* Custom styles for the quiz information section */
        #quiz-info {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border: 1px solid #cccccc;
            border-radius: 4px;
        }

        #quiz-info h1 {
            margin-top: 0;
        }

        #quiz-info p {
            font-size: 16px;
            margin: 5px 0;
        }

        #quiz-info ul li {
            font-size: 16px;
        }

        /* Custom styles for the top-rated players section */
        #top-players {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border: 1px solid #cccccc;
            border-radius: 4px;
        }

        #top-players h2 {
            margin-top: 0;
        }

        #top-players ul li {
            font-size: 16px;
            margin: 5px 0;
        }

        #challenge-form {
            margin: 20px;
            padding: 20px;
            background-color: white;
            border: 1px solid #cccccc;
            border-radius: 4px;
        }

        #challenge-form label {
            font-size: 16px;
            display: block;
            margin-bottom: 5px;
        }

        #challenge-form input[type="text"] {
            font-size: 14px;
            padding: 8px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            margin-bottom: 10px;
            width: 100%;
        }

        #challenge-form button {
            font-size: 14px;
            background-color: #66bb6a;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #challenge-form button:hover {
            background-color: #4caf50;
        }

        /* Custom styles for the buttons */
        .start-quiz-button {
            background-color: #1976D2;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            margin: 0 auto;
            margin-top: 20px;
        }

        .back-button {
            background-color: #43a047;
            color: white;
            font-size: 16px;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            position: absolute;
            top: 30px;
            right: 30px;
        }
    </style>
</head>
<body>
<%
    int quizId = Integer.parseInt(request.getParameter("id"));


    Quiz quiz = QuizzesInformation.findQuizById(quizId);

    int creatorId = quiz.getUserId();

    User creator = UsersInformation.findUserById(creatorId);


    Timestamp creationDate = quiz.getCreationDate();

    List<QuizHistory> topRatedPlayers = QuizHistoryInformation.getOrderedByScoreQuizzesHistoryByQuizId(quizId);
%>
<%!
    private String formatDate(java.util.Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
%>
<div id="quiz-info">
    <!-- Display the quiz information -->

    <h1>Quiz Name: <%= quiz.getName() %></h1>
    <p>Quiz Creator Name: <a href="profile?user_id=<%=creator.getUserId()%>">
        <%= creator.getUsername() %>
    </a></p>
    <p>Quiz Creation Date: <%= formatDate(creationDate) %></p>
</div>
<div>
    <form method="get" action="displayQuiz">
        <input type="hidden" name="id" value="<%=quizId%>">
        <button class="start-quiz-button" type="submit">Start Quiz</button>
    </form>
</div>

<div id="top-players">
    <h2>List of Top Scores:</h2>
    <ul>
        <% for (QuizHistory history : topRatedPlayers) { %>
        <li><a href="profile?user_id=<%=history.getUserId()%>">
            <%= UsersInformation.findUserById(history.getUserId()).getUsername() %>:</a>

                <%= history.getScore() %></li>
        <% } %>
    </ul>
</div>

<div id="challenge-form">
    <h2>Challenge a Friend</h2>
    <form method="post" action="challengeUser" onsubmit="return validateUsername(event);">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required>
        <br>
        <label for="message">Message:</label>
        <input type="text" name="message" id="message" required>
        <input type="hidden" name="current_active" value="<%= session.getAttribute("current_active") %>">
        <input type="hidden" name="current_quiz" value="<%= quizId %>">
        <br>
        <button type="submit">Send</button>
    </form>
</div>

<button class="back-button" onclick="goBack()">Back</button>

<script>
    function validateUsername(event) {
        event.preventDefault();

        var username = document.getElementById("username").value;
        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var isValid = JSON.parse(xhr.responseText);
                    if (!isValid) {
                        alert("Username is not valid.");
                    } else {
                        event.target.submit();
                    }
                } else {
                    alert("Error occurred while checking the username validity.");
                }
            }
        };

        xhr.open("GET", "checkUsernameValidity?username=" + encodeURIComponent(username), true);
        xhr.send();
    }

    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>
