<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.freeuni.quizwebsite.service.AdminInformation" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Statistics</title>
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
</head>
<body>
    <%
    if(session.getAttribute("current_active") == null||!UsersInformation.findUserById((Integer) session.getAttribute("current_active")).isAdmin()){
        request.setAttribute("not-logged", new Object());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    %>
<div id="header">
    <h1>Statistics Dashboard</h1>
</div>
<div id="container">
    <div id="left-column">
        <h2>User Statistics</h2>
        <p>Total Users: <%= AdminInformation.userAmount() %></p>
        <!-- Other user statistics here -->

        <h2>Quizzes Statistics</h2>
        <p>Total Quizzes: <%= AdminInformation.quizAmount() %></p>
        <!-- Other quiz statistics here -->
    </div>
    <div id="right-column">
        <h2>User Registrations in the Last Seven Days</h2>
        <table id="users">
            <tr>
                <th>Date</th>
                <th>Users Added</th>
            </tr>
            <%
                Map<LocalDate, Integer> userMap = AdminInformation.usersAddedLastSevenDays();
                for (LocalDate date : userMap.keySet()) {
            %>
            <tr class="quiz-item">
                <td><%= date %></td>
                <td><%= userMap.get(date) %></td>
            </tr>
            <%
                }
            %>
        </table>

        <h2>Quiz Histories in the Last Seven Days</h2>
        <table id="quizzes">
            <tr>
                <th>Date</th>
                <th>Quizzes Taken</th>
            </tr>
            <%
                Map<LocalDate, Integer> quizHistoryMap = AdminInformation.quizHistoriesTakenLastSevenDays();
                for (LocalDate date : quizHistoryMap.keySet()) {
            %>
            <tr class="quiz-item">
                <td><%= date %></td>
                <td><%= quizHistoryMap.get(date) %></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</div>
</body>
</html>
