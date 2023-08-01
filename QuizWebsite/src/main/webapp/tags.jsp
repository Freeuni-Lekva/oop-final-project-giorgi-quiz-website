<%@ page import="com.freeuni.quizwebsite.service.TagsInformation" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tags</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9; /* Light green background */
            margin: 0;
            padding: 0;
        }

        #tags-list {
            margin-top: 20px;
            padding: 10px;
            background-color: white;
        }

        .tag-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #cccccc;
            background-color: #f9f9f9;
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
        }

        .tag-item a {
            font-size: 16px;
            color: #888888;
            text-decoration: none;
        }

        .tag-item a:hover {
            color: #43a047; /* Dark green on hover */
        }

        .tag-group-header {
            font-size: 18px;
            color: #43a047; /* Dark green */
            font-weight: bold;
        }
    </style>
</head>
<body>
<% if (Integer.parseInt(request.getParameter("user_id")) != ((Integer) session.getAttribute("current_active")).intValue()) {
        throw new RuntimeException();
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
                <li class="tag-group-header"><%= letter %></li>
                <% for (String tag : groupedTags.get(letter)) { %>
                <li class="tag-item"><a href="#" onclick="redirectToTagPage('<%= tag %>')"><%= tag %></a></li>
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
