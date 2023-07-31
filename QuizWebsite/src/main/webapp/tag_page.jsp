<%@ page import="com.freeuni.quizwebsite.service.TagsInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tag</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9; /* Light green background */
            margin: 0;
            padding: 0;
        }

        /* Example styles for the tags list */
        #tags-list {
            margin-top: 20px;
            padding: 10px;
            background-color: white;
        }

        .tag-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #cccccc;
            background-color: #f9f9f9;
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

        .tag-item a {
            font-size: 16px;
            color: #888888;
            text-decoration: none;
        }

        .tag-item a:hover {
            color: #43a047; /* Dark green on hover */
        }

        /* Additional style for the group header */
        .tag-group-header {
            font-size: 18px;
            color: #43a047; /* Dark green */
            font-weight: bold;
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
        }
    </style>
    <!-- Link any necessary external stylesheets and scripts here -->
</head>
<body>
<div id="header">
    <h1>Quiz Website</h1>
    <!-- Add any header content common to all pages here -->
</div>
<div id="container">
    <div id="left-column">
        <!-- Add any left column content common to all pages here -->
    </div>
    <div id="right-column">
        <div id="tags-list">
            <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
            <%-- Get the tag name from the request parameter --%>
            <% String tagName = request.getParameter("tagName"); %>

            <h2><%= tagName %></h2> <%-- Display the tag name --%>

            <%-- Get the list of quizzes for the specified tag --%>
            <% List<Integer> quizIds = TagsInformation.getQuizzesIdByTagName(tagName); %>

            <%-- Display the quizzes for the specified tag --%>
            <ul>
                <% for (int quizId : quizIds) { %>
                <% com.freeuni.quizwebsite.model.db.Quiz quiz = QuizzesInformation.findQuizById(quizId); %>
                <li class="tag-item"><a href="#" onclick="redirectToQuiz('<%= quiz.getQuizId() %>')"><%= quiz.getName() %></a></li>
                <% } %>
            </ul>

            <!-- Back button to go back to the previous page -->
            <button class="back-button" onclick="goBack()">Back</button>
        </div>
    </div>
</div>
<!-- Add any additional content and scripts common to all pages here -->
<script>
    function redirectTo(url) {
        window.location.href = url;
    }
    function redirectToQuiz(quizId) {
        window.location.href = 'quiz?id=' + quizId;
    }
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>
