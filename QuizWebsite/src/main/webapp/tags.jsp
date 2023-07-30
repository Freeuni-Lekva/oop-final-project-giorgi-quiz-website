<%@ page import="com.freeuni.quizwebsite.service.TagsInformation" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tags</title>
    <style>
        /* Copy the CSS styles from the provided JSP here */

        /* Add any additional CSS styles for the tags page here */
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9; /* Light green background */
            margin: 0;
            padding: 0;
        }

        /* Example styles for the tags list */
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

        .tag-item a {
            font-size: 16px;
            color: #888888;
            text-decoration: none;
        }

        .tag-item a:hover {
            color: #43a047; /* Dark green on hover */
        }

        /* Additional style for the group header */
        .tag-group-header {
            font-size: 18px;
            color: #43a047; /* Dark green */
            font-weight: bold;
        }
    </style>
    <!-- Link any necessary external stylesheets and scripts here -->
</head>
<body>
<div id="header">
    <h1>Quiz Website</h1>
    <!-- Add any header content common to all pages here -->
</div>
<div id="container">
    <div id="left-column">
        <!-- Add any left column content common to all pages here -->
    </div>
    <div id="right-column">
        <div id="tags-list">
            <h2>Tags</h2>
            <%-- Get the list of tags from TagInformation --%>
            <% List<String> tags = TagsInformation.AllTagNames(); %>
            <%-- Sort the tags alphabetically --%>
            <% Collections.sort(tags); %>

            <%-- Group tags by their starting letter using a HashMap --%>
            <% Map<Character, List<String>> groupedTags = new HashMap<>(); %>
            <% for (String tag : tags) {
                char startingLetter = Character.toUpperCase(tag.charAt(0));
                if (!groupedTags.containsKey(startingLetter)) {
                    groupedTags.put(startingLetter, new ArrayList<>());
                }
                groupedTags.get(startingLetter).add(tag);
            } %>

            <%-- Display the tags grouped by their starting letter --%>
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
<!-- Add any additional content and scripts common to all pages here -->
<script>
    function redirectToTagPage(tagName) {
        // Assuming you have a JSP page named tag_page.jsp to display the details of each tag.
        window.location.href = 'tag_page.jsp?tagName=' + encodeURIComponent(tagName);
    }
</script>
</body>
</html>
