<%--
  Created by IntelliJ IDEA.
  User: Sandro
  Date: 7/30/2023
  Time: 3:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="com.freeuni.quizwebsite.service.FriendsInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Quiz" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.FriendRequestInformation" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        User profileInfo = (User) request.getAttribute("profileInfo");
        User currentUser = (User) request.getAttribute("currentUser");
    %>
    <title> <%= profileInfo.getUsername() %>'s profile </title>
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
            padding: 15px;
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

        #friends-list {
            margin-top: 20px;
            border: 1px solid #cccccc;
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

        .del-button {
            padding: 8px 16px;
            background-color: darkred;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
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

        function addFriend() {
            window.location.href = "friend-request?profile_id="+<%=profileInfo.getUserId()%>
                                            + "&req=false&rej=false";
        }

        function cancelRequest() {
            window.location.href = "friend-request?profile_id="+<%=profileInfo.getUserId()%>
                                            + "&req=true&rej=true";
        }

        function sendRequest() {
            window.location.href = "friend-request?profile_id="+<%=profileInfo.getUserId()%>
                                            + "&req=true&rej=false";
        }

        function unfriend() {
            window.location.href = "friend-request?profile_id="+<%=profileInfo.getUserId()%>
                                            + "&req=false&rej=true";
        }

        function deleteUser() {
            window.location.href = "delete-user?profile_id="+<%=profileInfo.getUserId()%>;
        }

    </script>
</head>
<body>
<div id="header">
    <h1>
        <a color="white" href="home_page.jsp">
            Quiz Website
        </a><br>
    </h1>
</div>
<div id="container">
    <div id="left-column">
        <div class="about-info">
            <h2>
                <%= profileInfo.getUsername() %>'s Basic Info:
            </h2>
            <h3>
                First Name: <%= profileInfo.getFirstName()%><br>
                Last Name:  <%= profileInfo.getLastName()%><br>
                Quizzer since: <%= new SimpleDateFormat("dd/MM/yyyy").format(profileInfo.getCreationDate())%><br>
            </h3>
            <% if (! profileInfo.getBio().isEmpty()) { %>
                <h4>
                    Some more about <%= profileInfo.getUsername() %>:
                        <%= profileInfo.getBio() %>
                </h4>
            <% } %>
        </div>
        <% if ((currentUser.getUserId() == profileInfo.getUserId())
                        || UsersInformation.findAdmins().contains(currentUser)) { %>
            <button class="del-button" onclick="deleteUser()">Delete Account</button>
        <% } %>
        <div id="quizzes">
            <h2><%= profileInfo.getUsername() %>'s Quizzes</h2>
            <% if(currentUser.getUserId() == profileInfo.getUserId()) { %>
                <button class="fun-button" onclick="redirectTo('create_quiz')">Create Quiz</button><br>
            <% } %>
            <%
                List<Quiz> quizzes;
                try {
                    quizzes = QuizzesInformation.findQuizzesByUserId(profileInfo.getUserId());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (Quiz quiz : quizzes) { %>
                <div class="quiz-item">
                    <a href="quiz.jsp?id=<%=quiz.getQuizId()%>">
                        <%=quiz.getName() %>
                    </a>
                </div>
                <% } %>
            <% if (quizzes.isEmpty()) { %>
                Looks like there's nothing to show yet :(
            <% } %>
        </div>
    </div>

    <div id="right-column">
        <% if (currentUser.getUserId() != profileInfo.getUserId()) { %>
            <div class="friend-buttons">

                 <% if (FriendsInformation.areFriends(currentUser.getUserId(), profileInfo.getUserId())) { %>
                    <button class="fun-button"
                            onclick="unfriend()">
                        Unfriend
                    </button>
                <% } else if (FriendRequestInformation
                                    .getSentFriendRequestsReceiverIds(currentUser.getUserId())
                                        .contains(profileInfo.getUserId())) { %>
                    <button class="fun-button"
                            onclick="cancelRequest()">
                        Cancel Request
                    </button>

                <% } else if (FriendRequestInformation
                                    .getReceivedFriendRequestsSenderIds(currentUser.getUserId())
                                        .contains(profileInfo.getUserId())) { %>
                    <button class="fun-button"
                            onclick="addFriend()">
                        Approve Request
                    </button>
                <% } else {%>
                    <button class="fun-button"
                            onclick="sendRequest()">
                        Add Friend
                    </button>
                <% } %>
            </div>
        <% } %>
    <div id="friends-list">
            <h2><%= profileInfo.getUsername() %>'s Friends</h2>
            <%-- Create a list of users using JSTL --%>
            <%
                List<User> friendsList;
                try {
                    friendsList = FriendsInformation.getAllFriends(profileInfo.getUserId());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (User friend : friendsList) {
            %>
                    <div class="friend-item">
                        <div class="friend-name">
                            <a href="profile?user_id=<%=friend.getUserId()%>">
                                <%=friend.getUsername() %>
                            </a>
                        </div>
                    </div>
            <% } %>
            <% if(friendsList.isEmpty()) { %> Not the friendliest of them all, I guess <%}%>
        </div>
        <!-- Add any additional content for the right column here -->
    </div>
</div>
</body>
</html>

