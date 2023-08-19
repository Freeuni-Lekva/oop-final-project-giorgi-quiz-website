<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Quiz" %>
<%@ page import="com.freeuni.quizwebsite.model.db.FriendRequest" %>
<%@ page import="com.freeuni.quizwebsite.model.db.Announcement" %>
<%@ page import="com.freeuni.quizwebsite.service.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>

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

    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script>
        function redirectTo(url) {
            window.location.href = url;
        }
    </script>
</head>
<body>
<%
    if(session.getAttribute("current_active") == null){
        request.setAttribute("not-logged", new Object());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>
<div id="header">
    <h1>Quiz Website</h1>
    <% if (UsersInformation.findUserById((Integer) session.getAttribute("current_active")).isAdmin()) { %>
    <button class="fun-button" style="margin-right: 10px;" onclick="redirectTo('statistic.jsp')">STATISTIC</button>
    <% } %>
    <button class="fun-button" style="margin-right: 10px;" onclick="redirectTo('top_Ten.jsp',<%=(Integer) session.getAttribute("current_active")%>)">TOP 10</button>
    <button class="fun-button" style="margin-right: 10px;" onclick="redirectTo('tags.jsp',<%=(Integer) session.getAttribute("current_active")%>)">TAGS</button>
    <button id="note_Mail-button" class="fun-button" style="margin-right: 10px;" onclick="redirectTo('note_Mail',<%=(Integer) session.getAttribute("current_active")%>)">Note Mail</button>
    <button id="challenges-button" class="fun-button" style="margin-right: 10px;" onclick="redirectTo('challenges',<%=(Integer) session.getAttribute("current_active")%>)">Challenges</button>
    <button class="fun-button" style="margin-right: auto;" onclick="redirectTo('logout.jsp')">Log Out</button>
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
        <button id="create_quiz-button" class="fun-button" style="margin-right: 10px;" onclick="redirectTo('create_quiz.jsp',<%=(Integer) session.getAttribute("current_active")%>)">Create Quiz</button>
        <div id="my-quizzes">
            <h2>My Quizzes</h2>
            <% List<Quiz> myQuizzes;
                try {
                    myQuizzes = QuizzesInformation.findQuizzesByUserId((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (myQuizzes.isEmpty()) { %>
            <p>You have no quizzes yet ;)</p>
            <% } else {
                for (Quiz quiz : myQuizzes) { %>
            <div class="quiz-item">
                <a href="quiz.jsp?id=<%=quiz.getQuizId()%>">
                    <%=quiz.getName() %>
                </a>
            </div>
            <% }
            } %>
        </div>
        <form action="search-results" method="get">
            <div id="search-bar">
                <input type="text" name="search-input" placeholder="Search">
                <button type="submit" class="fun-button">
                    <i class="fun-icon fas fa-search"></i> Search
                </button>
            </div>
        </form>
        <div id="quizzes">
            <h2>Your Friends' Quizzes</h2>
            <% List<Quiz> quizzes;
                try {
                    quizzes = QuizzesInformation.getFriendsQuizzes((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (quizzes.isEmpty()) { %>
            <p>There are no quizzes from your friends</p>
            <% } else {
                for (Quiz quiz : quizzes) { %>
            <div class="quiz-item">
                <a href="quiz.jsp?id=<%=quiz.getQuizId()%>">
                    <%=quiz.getName() %> by <%=UsersInformation.findUserById(quiz.getUserId()).getUsername() %>
                </a>
            </div>
            <% }
            } %>
        </div>
    </div>

    <div id="right-column">
        <div id="friends-list">
            <h2>Friends</h2>
            <% List<User> friendsList;
                try {
                    friendsList = FriendsInformation.getAllFriends((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (friendsList.isEmpty()) { %>
            <p>You have no friends yet. Start adding friends to see their quizzes!</p>
            <% } else {
                for (User friend : friendsList) { %>
            <div class="friend-item">
                <div class="friend-name">
                    <a href="profile?user_id=<%=friend.getUserId()%>">
                        <%=friend.getUsername() %>
                    </a>
                </div>
            </div>
            <% }
            } %>
            <button class="fun-button" onclick="redirectTo('add-friends')">
                <i class="fun-icon fas fa-user-plus"></i> Add Friends
            </button>
        </div>

        <div id="friend-requests">
            <h2>Friend Requests</h2>
            <% List<FriendRequest> friendRequests;
                try {
                    friendRequests = FriendRequestInformation.getReceivedFriendRequests((Integer) session.getAttribute("current_active"));
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (friendRequests.isEmpty()) { %>
            <p>Nobody wants to be your friend</p>
            <% } else {
                for (FriendRequest friendRequest : friendRequests) { %>
            <div class="friend-request-item">
                <div class="friend-name">
                    <a href="profile?user_id=<%=friendRequest.getUserOneId()%>">
                        <i class="fun-icon fas fa-user-friends"></i> <%=UsersInformation.findUserById(friendRequest.getUserOneId()).getUsername() %>
                    </a>
                </div>
                <div>
                    <button class="fun-button" onclick="redirectTo('accept_friend.jsp', <%=friendRequest.getUserOneId()%>)">
                        <i class="fun-icon fas fa-check"></i> Accept
                    </button>
                    <button class="fun-button" onclick="redirectTo('reject_friend.jsp', <%=friendRequest.getUserOneId()%>)">
                        <i class="fun-icon fas fa-times"></i> Reject
                    </button>
                </div>
            </div>
            <% }
            } %>
        </div>
    </div>
</div>
<script>
    function redirectTo(url, userId) {
        const fullURL = `${url}?user_id=${userId}`;
        window.location.href = fullURL;
    }
</script>
<form action="doAnnouncement" method="post">
    <%
        boolean isAdmin = UsersInformation.findUserById((Integer) session.getAttribute("current_active")).isAdmin();
        if (isAdmin) {
    %>
    <div id="admin-controls">
        <input type="text" id="announcement_text" placeholder="Enter announcement text" name="announcement-text" required>
        <!-- Add a hidden input field for current_active -->
        <input type="hidden" name="current_active" value="<%= session.getAttribute("current_active") %>">
        <input type="submit" value="post announcement">
    </div>
    <%
        }
    %>
</form>
<div id="announcements">
    <h2>Announcements</h2>
    <% List<Announcement> announcements;
        try {
            announcements = AnnouncementInformation.getLatestAnnouncements();
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
            <p><%= announcement.getAnnouncement() %></p>
        </div>
        <%-- Check if the announcement content exceeds a maximum height --%>
        <% if (announcement.getAnnouncement().length() > 150) { %>
        <button class="expand-button" id="expand-button-<%= announcement.getAnnouncementId() %>" onclick="toggleExpand(<%= announcement.getAnnouncementId() %>)">Expand</button>
        <% } %>
        <%!
            private String formatDate(java.util.Date date) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                return sdf.format(date);
            }
        %>
        <%-- Add small text below the announcement content --%>
        <p class="small-text">Posted on <%= formatDate(announcement.getCreationDate()) %></p>

    </div>


    <% } %>
</div>
<script>
    function toggleExpand(announcementId) {
        const announcementContent = document.getElementById(`announcement-content-${announcementId}`);
        const expandButton = document.getElementById(`expand-button-${announcementId}`);

        if (announcementContent.style.maxHeight) {
            announcementContent.style.maxHeight = null;
            expandButton.innerText = "Expand";
        } else {
            announcementContent.style.maxHeight = announcementContent.scrollHeight + "px";
            expandButton.innerText = "Collapse";
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const challengesButton = document.getElementById('challenges-button');
        const noteMailButton = document.getElementById('note_Mail-button');
        const previousChallengesCount = localStorage.getItem('challengesCount');
        const previousNoteMailsCount = localStorage.getItem('noteMailsCount');
        const currentChallengesCount = <%= ChallengesInformation.getUserReceivedChallenges((Integer) session.getAttribute("current_active")).size() %>;
        const currentNoteMailsCount = <%= NoteMailInformation.getUserReceivedNotes((Integer) session.getAttribute("current_active")).size() %>;

        if (previousChallengesCount && parseInt(previousChallengesCount) < currentChallengesCount) {
            challengesButton.style.backgroundColor = 'red';
        }

        if (previousNoteMailsCount && parseInt(previousNoteMailsCount) < currentNoteMailsCount) {
            noteMailButton.style.backgroundColor = 'red';
        }

        localStorage.setItem('challengesCount', currentChallengesCount.toString());
        localStorage.setItem('noteMailsCount', currentNoteMailsCount.toString());
    });

</script>
</body>
</html>
