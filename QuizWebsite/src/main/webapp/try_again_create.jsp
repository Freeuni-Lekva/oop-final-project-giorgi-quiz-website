<%--
  Created by IntelliJ IDEA.
  User: Saba
  Date: 7/23/2023
  Time: 7:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Account</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            text-align: center;
            margin: 50px;
        }
        h1 {
            color: #333333;
        }
        form {
            display: inline-block;
            border: 1px solid #cccccc;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px #cccccc;
            animation: fade-in 1s;
        }
        @keyframes fade-in {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: #4CAF50;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            padding: 10px;
            width: 250px;
            border: 1px solid #cccccc;
            border-radius: 5px;
            margin-bottom: 15px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #4CAF50;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error-message {
            color: #ff0000;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
    <script>
        function animateForm() {
            const inputs = document.getElementsByTagName("input");
            for (let i = 0; i < inputs.length; i++) {
                inputs[i].addEventListener("mouseover", function() {
                    this.style.transform = "rotate(10deg)";
                });
                inputs[i].addEventListener("mouseout", function() {
                    this.style.transform = "rotate(0deg)";
                });
            }
        }
    </script>
</head>
<body onload="animateForm()">
<h1>Create New Account</h1>
<p>Please enter your details for account creation.</p>
<%-- Display error message if available --%>
<% if (request.getAttribute("errorMessage") != null) { %>
<p class="error-message"><%= request.getAttribute("errorMessage") %></p>
<% } %>
<form action="create" method="post">
    <label for="first-name-label"> First Name: </label>
    <input type="text" id="first-name-label" name="firstname" required><br>
    <label for="last-name-label"> Last Name: </label>
    <input type="text" id="last-name-label" name="lastname" required><br>
    <label for="user-name-label"> Username: </label>
    <input type="text" id="user-name-label" name="username" required><br>
    <label for="password-label"> Password: </label>
    <input type="password" id="password-label" name="password" required><br>
    <label for="bio-label"> Bio: </label><br>
    <textarea id="bio-label" name="bio" rows="4" cols="50"></textarea><br><br>
    <input type="submit" value="Create Account">
</form>

</body>
</html>
