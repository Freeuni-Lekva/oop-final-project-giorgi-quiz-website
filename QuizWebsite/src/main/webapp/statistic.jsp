<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            background-color: #f5f5f5; /* Light gray background */
            margin: 0;
            padding: 0;
        }

        /* Improve header style */
        #header {
            background-color: #43a047; /* Dark green header */
            color: white;
            padding: 20px;
            text-align: center;
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

        /* Center the container */
        #container {
            display: flex;
            justify-content: center;
            margin: 20px;
        }

        /* Improve column styling */
        #left-column, #right-column {
            flex: 1;
            padding: 20px;
            background-color: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        /* Style for section headings */
        h2 {
            font-size: 24px;
            color: #43a047; /* Dark green text */
            margin-bottom: 10px;
        }

        /* Improve table styling */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #43a047; /* Dark green header */
            color: white;
        }

        /* Add more spacing for better readability */
        p {
            margin-bottom: 15px;
        }
    </style>
    <script>
        function redirectToHome() {
            window.location.href = "home_page.jsp";
        }
    </script>
</head>
<body>
<%
    if (session.getAttribute("current_active") == null || !UsersInformation.findUserById((Integer) session.getAttribute("current_active")).isAdmin()) {
        request.setAttribute("not-logged", new Object());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>
<div id="header">
    <h1>Statistics Dashboard</h1>
    <button class="home-button" onclick="redirectToHome()">Home</button>
</div>
<div id="container">
    <div id="left-column">
        <h2>User Statistics</h2>
        <p>Total Users: <%= AdminInformation.userAmount() %>
        </p>
        <p>Users Added Today: <%= AdminInformation.usersAddedToday() %>
        </p>

        <h2>Quizzes Statistics</h2>
        <p>Total Quizzes: <%= AdminInformation.quizAmount() %>
        </p>
        <p>Total Quiz Views: <%= AdminInformation.totalViews() %>
        </p>
        <p>Total Quiz Takes: <%= AdminInformation.totalQuizTake() %>
        </p>
        <p>Total Challenges Sent: <%= AdminInformation.totalChallenges() %>
        </p>
    </div>
    <div id="right-column">
        <h2>User Registrations in the Last Seven Days</h2>
        <table>
            <tr>
                <th>Date</th>
                <th>Users Added</th>
            </tr>
            <%
                Map<LocalDate, Integer> userMap = AdminInformation.usersAddedLastSevenDays();
                for (LocalDate date : userMap.keySet()) {
            %>
            <tr>
                <td><%= date %>
                </td>
                <td><%= userMap.get(date) %>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <h2>Quizzes History in the Last Seven Days</h2>
        <table>
            <tr>
                <th>Date</th>
                <th>Quizzes Taken</th>
            </tr>
            <%
                Map<LocalDate, Integer> quizHistoryMap = AdminInformation.quizHistoriesTakenLastSevenDays();
                for (LocalDate date : quizHistoryMap.keySet()) {
            %>
            <tr>
                <td><%= date %>
                </td>
                <td><%= quizHistoryMap.get(date) %>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</div>
</body>
</html>
