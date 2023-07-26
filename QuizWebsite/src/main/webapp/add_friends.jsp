<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.model.db.User" %>
<%@ page import="com.freeuni.quizwebsite.service.FriendsInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page import="com.freeuni.quizwebsite.model.db.FriendRequest" %>
<%@ page import="com.freeuni.quizwebsite.service.FriendRequestInformation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Friends</title>
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
<div id="header">
    <h1>Quiz Website - Add Friends</h1>
</div>
<div id="container">
    <h1>Add Friends</h1>
    <button class="home-button" onclick="redirectToHome()">Home</button>
    <div class="search-container">
        <input type="text" class="search-bar" placeholder="Search...">
        <button class="search-button">Search</button>
    </div>
    <ul>
        <% List<User> allUsers = (List<User>) request.getAttribute("allUsers");
            allUsers.remove(UsersInformation.findUserById((Integer) session.getAttribute("current_active")));
            List<User> friends = FriendsInformation.getAllFriends((Integer) session.getAttribute("current_active"));
            for (User friend : friends) {
                allUsers.remove(friend);
            }
            List<FriendRequest> friendRequests = FriendRequestInformation.getSentFriendRequests((Integer) session.getAttribute("current_active"));
            for (FriendRequest friendRequest : friendRequests){
                if(friendRequest.getUserOneId() == (Integer) session.getAttribute("current_active")){
                    User u = UsersInformation.findUserById(friendRequest.getUserTwoId());
                    allUsers.remove(u);
                }else{
                    User u = UsersInformation.findUserById(friendRequest.getUserOneId());
                    allUsers.remove(u);
                }
            }
            List<FriendRequest> friendReceived = FriendRequestInformation.getReceivedFriendRequests((Integer) session.getAttribute("current_active"));
            for (FriendRequest friendRequestReceived : friendReceived){
                if(friendRequestReceived.getUserOneId() == (Integer) session.getAttribute("current_active")){
                    User u = UsersInformation.findUserById(friendRequestReceived.getUserTwoId());
                    allUsers.remove(u);
                }else{
                    User u = UsersInformation.findUserById(friendRequestReceived.getUserOneId());
                    allUsers.remove(u);
                }
            }
            for (User user : allUsers) { %>
        <li>
            <a href="profile?user_id=<%= user.getUserId() %>" class="user-profile-link"><%= user.getUsername() %>
            </a>
            <a href="add-friend?user_id=<%= user.getUserId() %>">Add</a>
            <!-- Replace 'add-friend' with the URL for adding a friend -->
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
