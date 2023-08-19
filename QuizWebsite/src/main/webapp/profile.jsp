<%--
  Created by IntelliJ IDEA.
  User: Sandro
  Date: 7/30/2023
  Time: 3:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Quiz" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Achievement" %>
<%@ page import="com.freeuni.quizwebsite.service.*" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Announcement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        User profileInfo = (User) request.getAttribute("profileInfo");
        User currentUser = (User) request.getAttribute("currentUser");
    %>
    <title><%= profileInfo.getUsername() %>'s profile </title>
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

        .home-button {
            background-color: white; /* Dark green header color */
            color: #43a047;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 5px;
        }

        .home-button:hover {
            background-color: lightgrey; /* Dark green on hover */
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

        #tabs {
            display: flex;
            margin-left: 10px;
        }

        #quizzes {
            display: block;
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

        #achievements {
            display: none;
        }

        .achievement-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #cccccc;
            background-color: #f9f9f9;
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

        #del-button {
            padding: 8px 16px;
            background-color: darkred;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #bio-text {
            background-color: #A3D8FF;
            padding: 8px 16px;
            border: 1px;
            border-radius: 3px;
        }

        .textarea-container {
            width: 100%;
            /* Center the container horizontally */
            margin: 0 auto;
        }

        textarea {
            /* Make the textarea span the whole width of its parent */
            width: 100%;
            /* Apply additional styles as needed */
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 8px 12px;
            font-size: 14px;
            resize: vertical; /* Allow vertical resizing of the textarea */
            min-height: 100px; /* Set a minimum height to prevent it from collapsing */
        }

        /* Announcement styles */
        #announcements {
            display: none;
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

    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script>

        function redirectToHome() {
            window.location.href = "home_page.jsp";
        }

        function redirectTo(url) {
            window.location.href = url;
        }

        function addFriend() {
            window.location.href = "friend-request?profile_id=" + <%=profileInfo.getUserId()%>
                +"&req=false&rej=false";
        }

        function cancelRequest() {
            window.location.href = "friend-request?profile_id=" + <%=profileInfo.getUserId()%>
                +"&req=true&rej=true";
        }

        function sendRequest() {
            window.location.href = "friend-request?profile_id=" + <%=profileInfo.getUserId()%>
                +"&req=true&rej=false";
        }

        function unfriend() {
            window.location.href = "friend-request?profile_id=" + <%=profileInfo.getUserId()%>
                +"&req=false&rej=true";
        }

        function deleteUser() {
            window.location.href = "delete-user?profile_id=" +<%=profileInfo.getUserId()%>;
        }

        function chooseTab(tabIdx) {
            const quizzesDiv = document.getElementById('quizzes');
            const achievementsDiv = document.getElementById('achievements');
            const announcementsDiv = document.getElementById('announcements');
            quizzesDiv.style.display = 'none';
            achievementsDiv.style.display = 'none';
            <% if (profileInfo.isAdmin()) { %>
            announcementsDiv.style.display = 'none';
            <% } %>
            switch (tabIdx) {
                case 0:
                    quizzesDiv.style.display = 'block';
                    break;
                case 1:
                    achievementsDiv.style.display = 'block';
                    break;
                <% if (profileInfo.isAdmin()) { %>
                case 2:
                    announcementsDiv.style.display = 'block';
                    break;
                <% } %>
            }

        }

    </script>
</head>
<body>
<div id="header">
    <h1><%=profileInfo.getUsername()%></h1>
    <button class="home-button" onclick="redirectToHome()">Home</button>
</div>
<div id="container">
    <div id="left-column">
        <div id="profile-info">
            <h2>
                <%= profileInfo.getUsername() %>'s Basic Info:
            </h2>
            <h3>
                First Name: <%= profileInfo.getFirstName()%><br>
                Last Name:  <%= profileInfo.getLastName()%><br>
                Quizzer since: <%= new SimpleDateFormat("dd/MM/yyyy").format(profileInfo.getCreationDate())%><br>
            </h3>
            <% if (!profileInfo.getBio().isEmpty()) { %>
            <h4>
                Some more about <%= profileInfo.getUsername() %>:
                <div id="bio-text">
                    <%= profileInfo.getBio() %>
                </div>
            </h4>
            <% } %>
        </div>
        <% if ((currentUser.getUserId() == profileInfo.getUserId())
                || (currentUser.isAdmin()) && !profileInfo.isAdmin()) { %>
        <button id="del-button" onclick="deleteUser()">Delete Account</button>
        <% } %>
        <div id="tabs">
            <button onclick="chooseTab(0)" class="fun-button">Quizzes</button>
            <button onclick="chooseTab(1)" class="fun-button">Achievements</button>
            <% if (profileInfo.isAdmin()) { %>
            <button onclick="chooseTab(2)" class="fun-button">Announcements</button>
            <% } %>
        </div>
        <div id="quizzes">
            <h2><%= profileInfo.getUsername() %>'s Quizzes</h2>
            <% if (currentUser.getUserId() == profileInfo.getUserId()) { %>
            <button class="fun-button" onclick="redirectTo('create_quiz.jsp')">Create Quiz</button>
            <br>
            <br>
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
        <div id="achievements">
            <h2><%= profileInfo.getUsername() %>'s Achievements</h2>
            <% List<Achievement> achievements;
                try {
                    achievements = AchievementsInformation.findAchievementsByUserId(currentUser.getUserId());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (Achievement achievement : achievements) { %>
            <div class="achievement-item">
                <p><%= achievement.getAchivementName()%>
                </p>
            </div>
            <% } %>
            <% if (achievements.isEmpty()) { %>
            Looks like there's nothing to show yet :(
            <% } %>
        </div>
        <% if (profileInfo.isAdmin()) { %>
        <div id="announcements">
            <h2><%= profileInfo.getUsername() %>'s Announcements</h2>
            <% List<Announcement> announcements;
                try {
                    announcements = AnnouncementInformation.getLatestAnnouncementsById(profileInfo.getUserId());
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                for (Announcement announcement : announcements) { %>
            <div class="announcement-item">
                <div class="announcement-header">
                    Announcement by
                    <a href="profile?user_id=<%= announcement.getUserId() %>">
                        <%= UsersInformation.findUserById(announcement.getUserId()).getUsername() %>
                    </a>
                </div>

                <div class="announcement-content" id="announcement-content-<%= announcement.getAnnouncementId() %>">
                    <p><%= announcement.getAnnouncement() %>
                    </p>
                </div>
                <%-- Check if the announcement content exceeds a maximum height --%>
                <% if (announcement.getAnnouncement().length() > 150) { %>
                <button class="expand-button" id="expand-button-<%= announcement.getAnnouncementId() %>"
                        onclick="toggleExpand(<%= announcement.getAnnouncementId() %>)">Expand
                </button>
                <% } %>
                <%!
                    private String formatDate(java.util.Date date) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                        return sdf.format(date);
                    }
                %>
                <%-- Add small text below the announcement content --%>
                <p class="small-text">Posted on <%= formatDate(announcement.getCreationDate()) %>
                </p>

            </div>


            <% } %>
        </div>
        <% } %>
    </div>

    <div id="right-column">
        <% if (currentUser.getUserId() != profileInfo.getUserId()) { %>
        <form action="note_Mail" method="post">
            <div class="textarea-container">
                <label for="mail-text"> Note Mail: </label>
                <br>
                <input type="hidden" name="profileId" value="<%=profileInfo.getUserId()%>">
                <textarea id="mail-text" name="mailText"></textarea>
            </div>
            <input class="fun-button" type="submit" value="Send Note Mail">
        </form>
        <% } %>

        <div id="friends-list">
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
                        onclick="addFriend()"
                        float="left">
                    Approve Request
                </button>
                <button class="fun-button"
                        onclick="cancelRequest()"
                        float="right">
                    Reject Request
                </button>
                <% } else {%>
                <button class="fun-button"
                        onclick="sendRequest()">
                    Add Friend
                </button>
                <% } %>
            </div>
            <% } %>

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
            <% if (friendsList.isEmpty()) { %> Not the friendliest of them all, I guess <%}%>
        </div>
    </div>
</div>
</body>
</html>

