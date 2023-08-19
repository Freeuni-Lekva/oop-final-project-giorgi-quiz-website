<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 8/14/2023
  Time: 11:24 PM
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

        .next-button {
            background-color: #1976D2;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            position: absolute;
            bottom: 15%;
        }

        .next-button:hover {
            background-color: #0056b3;
        }

        label {
            color: darkslateblue;
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
                String question = questions.get(cnt).getQuestion();
            %>
            <div class="answer-container">
                <p><%=question%></p>
                <p> possible answers: </p>
                <%
                    List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(questions.get(cnt).getQuestionId());
                    for (int j = 0; j < possibleAnswers.size(); j++) {
                %>
                <input type="checkbox" id="ans_<%= j %>" name="guess<%=cnt%>" value="<%=possibleAnswers.get(j)%>">
                <label for="ans_<%= j %>"> <%=possibleAnswers.get(j)%> </label>
                <br>
                <%  }
                    cnt++;
                    request.getSession().setAttribute("queue", cnt);
                %>
            </div>
        </div>
        <input class="next-button" type="submit" id="next" value="Next"/>
    </form>
</body>
</html>
