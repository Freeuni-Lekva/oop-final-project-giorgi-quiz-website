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

        #header {
            background-color: #43a047; /* Dark green header */
            color: white;
            padding: 10px;
        }

        #container {
            display: flex;
            margin: 10px;
        }

        #left-column {
            flex: 2;
            padding: 10px;
        }

        #right-column {
            flex: 1;
            padding: 10px;
            background-color: #dcedc8; /* Light green right column */
        }

        .user-profile {
            display: flex;
            align-items: center;
            padding: 10px;
            cursor: pointer;
        }

        .user-profile:hover {
            background-color: #f2f2f2;
        }

        .user-name {
            font-weight: bold;
            font-size: 16px;
            margin-left: 10px;
        }

        #friends-list {
            margin-top: 20px;
            border: 1px solid #cccccc;
            padding: 10px;
            background-color: white;
        }

        #search-bar {
            margin-top: 20px;
            padding: 10px;
            background-color: white;
        }

        .friend-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            cursor: pointer;
        }

        .friend-item img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .friend-item:hover {
            background-color: #f2f2f2;
        }

        .friend-name {
            font-size: 14px;
            margin-left: 10px;
        }

        #quizzes {
            margin-top: 20px;
            padding: 10px;
            background-color: white;
        }

        .quiz-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #cccccc;
            background-color: #f9f9f9;
        }

        .quiz-item p {
            font-size: 14px;
            color: #888888;
        }

        .quiz-item:hover {
            background-color: #c5e1a5; /* Light green on hover */
        }

        .friend-name:hover {
            color: #43a047; /* Dark green on hover */
        }

        /* Button styles */
        .fun-button {
            background-color: #66bb6a;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 10px;
        }

        .fun-button:hover {
            background-color: #4caf50;
        }

        /* Icon styles */
        .fun-icon {
            font-size: 20px;
            margin-right: 5px;
        }

        /* Friend Requests styles */
        .friend-request-item {
            display: flex;
            align-items: center;
            justify-content: space-between; /* Align buttons in the same column */
            margin-bottom: 10px;
        }

        .friend-request-item .friend-name {
            flex: 1; /* Take up remaining space */
        }

        .friend-request-item .friend-buttons {
            display: flex;
            gap: 10px;
        }
        /* Announcement styles */
        #announcements {
            margin-top: 20px;
            padding: 10px;
            background-color: palegreen;
        }

        .announcement-item {
            border: 1px solid #c5e1a5;
            padding: 10px;
            margin-bottom: 10px;
        }

        .announcement-header {
            font-weight: bold;
        }

        .announcement-content {
            max-height: 100px; /* Set a maximum height for the announcement content */
            overflow: hidden; /* Hide any content that exceeds the max-height */
        }

        .expand-button {
            cursor: pointer;
            background-color: dodgerblue;
            color: white;
            padding: 10px 20px; /* Optional: Add padding for better appearance */
            border: none; /* Optional: Remove border for a cleaner look */
        }
        .small-text {
            font-size: 10px; /* Adjust the font size to make the text smaller */
            color: #888888;
        }

        /* Style for the header */
        #header {
            background-color: #43a047;
            color: white;
            padding: 10px;
            display: flex;
            align-items: center;
        }

        #header h1 {
            font-size: 32px;
            margin: 0;
            flex: 1;
        }

        /* Style for the user profile section */
        .user-profile {
            display: flex;
            align-items: center;
            padding: 10px;
            cursor: pointer;
            margin-bottom: 20px;
            border-bottom: 1px solid #cccccc;
        }

        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .user-name {
            font-weight: bold;
            font-size: 20px;
        }

        /* Style for the "My Quizzes" section */
        #my-quizzes {
            margin-bottom: 20px;
        }

        #my-quizzes h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }

        /* Style for the "Your Friends' Quizzes" section */
        #quizzes {
            margin-bottom: 20px;
        }

        #quizzes h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }

        /* Style for the "Friends" section */
        #friends-list {
            margin-bottom: 20px;
        }

        #friends-list h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }

        .friend-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            cursor: pointer;
            padding: 10px;
            border: 1px solid #cccccc;
            background-color: #f2f2f2;
            transition: background-color 0.3s;
        }

        .friend-item img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .friend-item:hover {
            background-color: #c5e1a5;
        }

        /* Style for the "Friend Requests" section */
        #friend-requests {
            margin-bottom: 20px;
        }

        #friend-requests h2 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #43a047;
        }

        .friend-request-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #cccccc;
            background-color: #f2f2f2;
            transition: background-color 0.3s;
        }

        .friend-request-item img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .friend-request-item:hover {
            background-color: #c5e1a5;
        }
        #admin-controls input[type="submit"] {
            background-color: dodgerblue;
            border-radius: 4px; /* Add border-radius to make the button less square */
            padding: 8px 20px; /* Adjust padding to make the button wider */
            margin-left: 10px; /* Adjust the margin to move the button a bit to the right */
        }

        #admin-controls input[type="text"] {
            font-size: 16px; /* Adjust the font size to make the text field bigger */
            margin-right: 10px; /* Adjust the margin to move the text field a bit to the right */
            margin-left: 10px; /* Adjust the margin to move the text field a bit to the right */
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

        /* Custom styles for the challenge form */
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
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
<%
    // Get the quiz ID from the request parameter
    int quizId = Integer.parseInt(request.getParameter("id"));

    // Retrieve the quiz information
    Quiz quiz = QuizzesInformation.findQuizById(quizId);

    // Retrieve the quiz creator information
    int creatorId = quiz.getUserId();
    User creator = UsersInformation.findUserById(creatorId);


    // Retrieve the quiz creation date
    Timestamp creationDate = quiz.getCreationDate();

    // Retrieve the list of top-rated players who took this quiz
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
    <p><a href="profile?user_id=<%=creatorId%>">Quiz Creator Name: <%= creator.getUsername() %></p>
    <p>Quiz Creation Date: <%= formatDate(creationDate) %></p>
</div>
<div>
    <!-- Start Quiz Button -->
    <form method="get" action="start_quiz.jsp">
        <input type="hidden" name="id" value="<%=quizId%>">
        <button class="start-quiz-button" type="submit">Start Quiz</button>
    </form>
</div>

<div id="top-players">
    <!-- Display the list of top-rated players -->
    <h2>List of Top Scores:</h2>
    <ul>
        <% for (QuizHistory history : topRatedPlayers) { %>
        <li><a href="profile?user_id=<%=history.getUserId()%>"><%= UsersInformation.findUserById(history.getUserId()).getUsername() %>: <%= history.getScore() %></a></li>
        <% } %>
    </ul>
</div>

<!-- Challenge Form -->
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

<!-- Back Button -->
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
