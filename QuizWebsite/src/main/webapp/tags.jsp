<%@ page import="com.freeuni.quizwebsite.service.TagsInformation" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tags</title>
    <style>
        #header {
            background-color: #43a047;
            color: darkslategrey;
            padding: 20px;
            text-align: left;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 0;
        }

        #tags-list {
            margin-top: 20px;
            padding: 20px;
            background-color: #e8f5e9;
        }

        .tag-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #007bff;
            background-color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .home-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .home-button:hover {
            background-color: #0056b3;
        }

        .tag-item a {
            font-size: 16px;
            color: #333;
            text-decoration: none;
        }

        .tag-item a:hover {
            color: #43a047;
        }

        .tag-group-header {
            font-size: 18px;
            color: #333;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<% if (session.getAttribute("current_active") == null
        || Integer.parseInt(request.getParameter("user_id")) != (Integer) session.getAttribute("current_active")) {
    request.setAttribute("not-logged", new Object());
    request.getRequestDispatcher("index.jsp").forward(request, response);
} %>
<div id="header">
    <h1>Quiz Website</h1>
</div>
<div id="container">
    <div id="left-column">
    </div>
    <div id="right-column">
        <div id="tags-list">
            <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
            <h2>Tags</h2>
            <% List<String> tags = TagsInformation.AllTagNames(); %>
            <% Collections.sort(tags); %>

            <% Map<Character, List<String>> groupedTags = new HashMap<>(); %>
            <% for (String tag : tags) {
                char startingLetter = Character.toUpperCase(tag.charAt(0));
                if (!groupedTags.containsKey(startingLetter)) {
                    groupedTags.put(startingLetter, new ArrayList<>());
                }
                groupedTags.get(startingLetter).add(tag);
            } %>

            <ul>
                <% for (char letter : groupedTags.keySet()) { %>
                <li class="tag-group-header"><%= letter %>
                </li>
                <% for (String tag : groupedTags.get(letter)) { %>
                <li class="tag-item"><a href="#" onclick="redirectToTagPage('<%= tag %>')"><%= tag %>
                </a></li>
                <% } %>
                <% } %>
            </ul>
        </div>
    </div>
</div>
<script>
    function redirectTo(url) {
        window.location.href = url;
    }

    function redirectToTagPage(tagName) {
        window.location.href = 'tag_page.jsp?tagName=' + encodeURIComponent(tagName);
    }
</script>
</body>
</html>
