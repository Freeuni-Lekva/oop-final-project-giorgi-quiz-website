<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Quiz Website</title>
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
        .login-form {
            display: inline-block;
            border: 1px solid #cccccc;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px #cccccc;
            animation: fade-in 1s;
            max-width: 400px;
            margin: 0 auto;
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
        .try-again-link {
            color: #ff0000;
            text-decoration: none;
            font-weight: bold;
        }
        .try-again-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<h1>Login to Quiz Website</h1>
<div class="login-form">
    <form action="login" method="post">
        <%-- Display error message if available --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: #ff0000;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        <label for="username-label">Username: </label>
        <input type="text" id="username-label" name="username" required><br>
        <label for="password-label">Password: </label>
        <input type="password" id="password-label" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <p>Don't have an account? <a href="create" class="try-again-link">Create Account</a></p>
</div>
</body>
</html>
