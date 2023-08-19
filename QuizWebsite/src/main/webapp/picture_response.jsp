<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 8/15/2023
  Time: 1:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>

        #question-info {
            border: 1px solid #cccccc;
            color: #333333;
            background-color: #f2f2f2;
            border-radius: 4px;
            width: 100%;
            margin-bottom: 10px;
            position: absolute;
            top: 25%;
        }

        .answer-container {
            padding: 50px;
            padding-top: 4px;

        }

        body {
            font-family: Arial, sans-serif;
            background-color: #B0C4DE;
            color: darkslateblue;
        }

        h1 {
            color: #00008B;
            margin-top: 5%;
            text-align: center;
        }

        #question-info h1 {
            color: #00008B;
            text-align: initial;
            margin: 0;
            margin-top: 3%;
            margin-left: 50px;
        }

        h2 {
            color: #0000CD;
            margin: 10px 0;
        }

        p {
            color: darkslateblue;
            margin-bottom: 10px;
        }

        .image {
            padding: 10px;
            padding-left: 0;
        }

        .answer-input {
            padding: 5px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        .next-button {
            background-color: #00008B;
            color: lightcyan;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            position: fixed;
            bottom: 15%;
        }

        .next-button:hover {
            background-color: #0056b3;
        }
    </style>
    <title>Question <%=(int)request.getSession().getAttribute("queue") +1%></title>
</head>
<body>
    <H1>Quiz: <%=QuizzesInformation.findQuizById((int)request.getSession().getAttribute("quizId")).getName()%></H1>
    <form method="post" action="transition">
        <% int cnt = (int) request.getSession().getAttribute("queue"); %>
        <div id="question-info">
            <h1>Question <%=cnt+1%></h1>
            <% ArrayList<Question> questions = (ArrayList<Question>) request.getSession().getAttribute("questions");
            String question = questions.get(cnt).getQuestion(); %>
            <div class="answer-container" id="text-field_question">
                <p><%=question%></p>
                <img class="image" src="<%=questions.get(cnt).getPicURL()%>" alt="pic for question <%= cnt + 1 %>" width="500" height="600">
                <br>
                <input class="answer-input" type="text" name="guess<%=cnt%>"/>
            </div>
        <%
            cnt++;
            request.getSession().setAttribute("queue", cnt);
        %>
        </div>
        <button class="next-button" type="submit">Next</button>
    </form>
</body>
</html>
