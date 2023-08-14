<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Quiz" %>
<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="com.freeuni.quizwebsite.service.FriendsInformation" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Quiz Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9; /* Light green background */
            margin: 0;
            padding: 0;
        }

        /*#header {*/
        /*    background-color: #e8f5e9; !* Dark green header *!*/
        /*    color: white;*/
        /*    padding: 10px;*/
        /*}*/

        #container {
            margin: 10px;
        }

        h1 {
            color: #43a047; /* Dark green header text color */
            margin: 10px 0;
        }

        .search-container {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .search-bar {
            flex: 1;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
        }

        .search-button {
            background-color: #66bb6a; /* Green search button background */
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 5px;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        li {
            background-color: #dcedc8; /* Light green list item background */
            padding: 10px;
            margin-bottom: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        li a {
            color: white;
            background-color: #66bb6a; /* Green 'Add' button background */
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 4px;
        }

        li a:hover {
            background-color: #4caf50; /* Dark green 'Add' button background on hover */
        }

        .home-button {
            background-color: #43a047; /* Dark green header color */
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 5px;
        }

        .home-button:hover {
            background-color: #4caf50; /* Dark green on hover */
        }
    </style>
</head>
<body>
<% if (session.getAttribute("current_active") == null) {
    request.setAttribute("not-logged", new Object());
    request.getRequestDispatcher("index.jsp").forward(request, response);
} %>
<div id="container">
    <h1>Search Results</h1>
    <button class="home-button" onclick="redirectToHome()">Home</button>
    <p></p>
    <form action="search-results" method="get">
        <div class="search-container">
            <input type="text" id="search-input" name="search-input" class="search-bar" placeholder="Search...">
            <button class="search-button">Search</button>
        </div>
    </form>
    <h1>Quiz Results</h1>
    <ul>
        <% List<Quiz> quizzes = (List<Quiz>) request.getAttribute("Quizzes");
            List<User> users = (List<User>) request.getAttribute("Users");
            for (Quiz quiz : quizzes) { %>
        <li>
            <a href="quiz.jsp?id=<%= quiz.getQuizId() %>" class="user-profile-link"> <%= quiz.getName() %>
            </a>
        </li>
        <% } %>
        <h1>User Results</h1>
         <%  for (User user : users) {
                 if(user.getUserId() == (int) session.getAttribute("current_active")) continue;
         %>
        <li>
            <a href="profile?user_id=<%= user.getUserId() %>" class="user-profile-link"> <%= user.getUsername() %>
            </a>
        </li>
        <% } %>

    </ul>
</div>
<script>
    function redirectToHome() {
        window.location.href = "home_page.jsp";
    }
</script>
</body>
</html>
