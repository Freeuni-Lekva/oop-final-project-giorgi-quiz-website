<%@ page import="com.freeuni.quizwebsite.service.TagsInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tag</title>
    <style>
        #header {
            background-color: #43a047;
            color: darkslategrey;
            padding: 20px;
            text-align: left;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5; /* Light gray background */
            margin: 0;
            padding: 0;
        }

        #tags-list {
            margin-top: 20px;
            padding: 20px; /* Increased padding for better spacing */
            background-color: #e8f5e9; /* Light green background for the container */
            border-radius: 10px; /* Rounded corners for the container */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Box shadow for a card-like appearance */
        }

        .tag-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #007bff; /* Light blue border for tags */
            background-color: #fff; /* White background */
            border-radius: 5px; /* Rounded corners for tags */
            transition: background-color 0.3s ease; /* Smooth hover effect */
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
            transition: background-color 0.3s ease; /* Smooth hover effect */
        }

        .home-button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        .tag-item a {
            font-size: 16px;
            color: #333; /* Dark text color */
            text-decoration: none;
        }

        .tag-item a:hover {
            color: #43a047; /* Dark green on hover */
        }

        .back-button {
            background-color: #f44336; /* Red */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s ease; /* Smooth hover effect */
        }

        .back-button:hover {
            background-color: #d32f2f; /* Darker red on hover */
        }
    </style>
</head>
<body>
<div id="header">
    <h1>Quiz Website</h1>
</div>
<div id="container">
    <div id="left-column"></div>
    <div id="right-column">
        <div id="tags-list">
            <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
            <%-- Get the tag name from the request parameter --%>
            <% String tagName = request.getParameter("tagName"); %>

            <h2><%= tagName %>
            </h2>

            <% List<Integer> quizIds = TagsInformation.getQuizzesIdByTagName(tagName); %>

            <ul>
                <% for (int quizId : quizIds) { %>
                <% com.freeuni.quizwebsite.model.db.Quiz quiz = QuizzesInformation.findQuizById(quizId); %>
                <li class="tag-item"><a href="#"
                                        onclick="redirectToQuiz('<%= quiz.getQuizId() %>')"><%= quiz.getName() %>
                </a></li>
                <% } %>
            </ul>

            <button class="back-button" onclick="goBack()">Back</button>
        </div>
    </div>
</div>
<script>
    function redirectTo(url) {
        window.location.href = url;
    }

    function redirectToQuiz(quizId) {
        window.location.href = 'quiz.jsp?id=' + quizId;
    }

    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>
