<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="com.freeuni.quizwebsite.service.FriendsInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Quiz" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.FriendRequestInformation" %>
<%@ page import="com.freeuni.quizwebsite.model.db.FriendRequest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quiz Website - Home</title>
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
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script>
        function redirectTo(url) {
            window.location.href = url;
        }
    </script>
</head>
<body>
<div id="header">
    <h1>Quiz Website</h1>
</div>
<div id="container">
    <div id="left-column">
        <div class="user-profile">
            <div class="user-name">
                <a href="profile?user_id=<%= session.getAttribute("current_active") %>">
                    <%= UsersInformation.findUserById((Integer) session.getAttribute("current_active")).getUsername() %>
                </a>
            </div>
        </div>
        <button class="fun-button" onclick="redirectTo('create_quiz')">Create Quiz</button>
        <div id="my-quizzes">
            <h2>My Quizzes</h2>
            <%
                List<Quiz> myQuizzes;
                try {
                    myQuizzes = QuizzesInformation.findQuizzesByUserId((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (Quiz quiz : myQuizzes) { %>
            <div class="quiz-item">
                <a href="quiz?id=<%=quiz.getQuizId()%>">
                    <%=quiz.getName() %>
                </a>
            </div>
            <% } %>
        </div>
        <div id="search-bar">
            <input type="text" placeholder="Search">
            <button class="fun-button" onclick="redirectTo('search-results')">
                <i class="fun-icon fas fa-search"></i> Search
            </button>
        </div>
        <div id="quizzes">
            <h2>Your Friends' Quizzes</h2>
            <%
                List<Quiz> quizzes;
                try {
                    quizzes = QuizzesInformation.getFriendsQuizzes((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (Quiz quiz : quizzes) { %>
            <div class="quiz-item">
                <a href="quiz?id=<%=quiz.getQuizId()%>">
                    <%=quiz.getName() %> by <%=UsersInformation.findUserById(quiz.getUserId()).getUsername() %>
                </a>
            </div>
            <% } %>
        </div>
    </div>

    <div id="right-column">
        <div id="friends-list">
            <h2>Friends</h2>
            <%-- Create a list of users using JSTL --%>
            <%
                List<User> friendsList;
                try {
                    friendsList = FriendsInformation.getAllFriends((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (User friend : friendsList) { %>
            <div class="friend-item">
                <div class="friend-name">
                    <a href="profile?user_id=<%=friend.getUserId()%>">
                        <%=friend.getUsername() %>
                    </a>
                </div>
            </div>
            <% } %>
            <button class="fun-button" onclick="redirectTo('add-friends')"> <!-- Replace 'add-friends' with your add friends URL -->
                <i class="fun-icon fas fa-user-plus"></i> Add Friends
            </button>
        </div>
        <div id="friend-requests">
            <h2>Friend Requests</h2>
            <!-- Create a list of pending friend requests using JSTL -->
            <% List<FriendRequest> friendRequests;
                try {
                    friendRequests = FriendRequestInformation.getReceivedFriendRequests((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (FriendRequest friendRequest : friendRequests) { %>
            <div class="friend-request-item">
                <div class="friend-name">
                    <a href="profile?user_id=<%=friendRequest.getUserOneId()%>">
                        <i class="fun-icon fas fa-user-friends"></i> <%=UsersInformation.findUserById(friendRequest.getUserOneId()).getUsername() %>
                    </a>
                </div>
                <div>
                    <button class="fun-button" onclick="acceptFriend('<%=friendRequest.getUserOneId()%>')">
                        <i class="fun-icon fas fa-check"></i> Accept
                    </button>
                    <button class="fun-button" onclick="rejectFriend('<%=friendRequest.getUserOneId()%>')">
                        <i class="fun-icon fas fa-times"></i> Reject
                    </button>
                </div>
            </div>
            <% } %>
        </div>
        <!-- Add any additional content for the right column here -->
    </div>
</div>
</body>
</html>
