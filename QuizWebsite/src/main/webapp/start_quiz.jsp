<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.model.QuestionType" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
<%@ page import="java.util.Collections" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<%
    String quiz = request.getParameter("id");
    int quizId = Integer.parseInt(quiz);
%>
<head>
    <title>Quiz Questions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: rgba(119, 131, 211, 0.67);
            margin: 0;
            padding: 0;
            color: rgba(107, 47, 211, 1);
        }

        h1 {
            color: #00008B;
            padding-left: 10px;
        }

        .question-container h3 {
            text-align: right;
        }

        .question-container h2 {
            text-align: left;
        }

        #quiz-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .question-container {
            border: 1px solid #cccccc;
            color: #333333;
            background-color: #f2f2f2;
            border-radius: 4px;
            padding: 15px;
            padding-top: 0;
            margin-bottom: 10px;
        }

        /*.question-container-wrong {*/
        /*    border: 1px solid #cccccc;*/
        /*    color: indianred;*/
        /*    background-color: moccasin;*/
        /*    border-radius: 4px;*/
        /*    padding: 15px;*/
        /*    margin-bottom: 10px;*/
        /*}*/

        /*.question-container-right {*/
        /*    border: 1px solid #cccccc;*/
        /*    color: darkgreen;*/
        /*    background-color: #cccccc;*/
        /*    border-radius: 4px;*/
        /*    padding: 15px;*/
        /*    margin-bottom: 10px;*/
        /*}*/

        .question-text {
            font-size: 18px;
            margin-bottom: 16px;
            margin-top: 0;
        }

        .answer-container {
            margin-top: 10px;
        }

        .answer-label {
            display: block;
            margin: 5px 0;
        }

        .answer-input {
            padding: 5px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        #tabs {
            display: flex;
            margin-left: 15px;
            margin-top: 7px;
            margin-bottom: 7px;
        }

        .fun-button {
            background-color: #00008B;
            color: lightcyan;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .fun-button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function addTextField(guessIdx) {
            const container = document.getElementById("text-field_question"+guessIdx);
            const newTextField = document.createElement("input");
            newTextField.className = "answer-input";
            newTextField.type = "text";
            newTextField.name = "guess"+guessIdx;
            container.appendChild(document.createElement("br"));
            container.appendChild(newTextField);
        }
    </script>
</head>
<body>
<%
    if(session.getAttribute("current_active") == null) {
        request.setAttribute("not-logged", new Object());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>

<div id="quiz-container">
    <h1> <%= QuizzesInformation.findQuizById(quizId).getName() %> </h1>
    <form action="evaluation" method="post">
        <%
            List<Question> questions = QuestionInformation.getQuestionsInQuiz(quizId);
            if(! QuizzesInformation.findQuizById(quizId).isSorted()) {
                Collections.shuffle(questions);
            }
            for (int i = 0; i < questions.size(); i++) {
                Question question = questions.get(i);
                String questionText = question.getQuestion();
        %>
        <input type="hidden" name="questionId<%= i %>" value="<%= question.getQuestionId() %>"/>
        <% if (question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE.name())
            || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())
                || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())) { %>
        <div class="question-container" id="question<%= i %>">
            <h2> Question <%= i + 1 %> </h2>
            <p class="question-text"> <%= questionText %> </p>
            <div class="answer-container" id="text-field_question<%= i %>">
                <input class="answer-input" type="text" name="guess<%= i %>"/>
            </div>
            <% if (question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())
                    || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())) { %>
            <button class="fun-button" type="button" onclick="addTextField(<%= i %>)">Add New Text Field</button>
            <% } %>
        </div>
        <% } else if (question.getQuestionType().equals(QuestionType.PICTURE_RESPONSE.name())) { %>
        <div class="question-container">
            <h2> Question <%= i + 1 %> </h2>
            <p> <%= questionText %> </p>
            <img src="<%=question.getPicURL()%>" alt="pic for question <%= i + 1 %>" width="600" height="500">
            <br>
            <input class="answer-input" type="text" name="guess<%= i %>"/>
        </div>
        <% } else if (question.getQuestionType().equals(QuestionType.FILL_IN_BLANK.name())) {
                StringTokenizer questionTokens = new StringTokenizer(questionText, "_");
        %>
        <div class="question-container">
            <h2> Question <%= i + 1 %> </h2>
            <p> Fill in the blanks: </p>
            <p>
                <% if (questionText.startsWith("_")) { %>
                <input type="text" name="guess<%= i %>"/>
                <% } %>
                <%=questionTokens.nextToken()%>
                <%while (questionTokens.hasMoreTokens()) { %>
                <input type="text" name="guess<%= i %>"/><%=questionTokens.nextToken()%>
                <% }
                if (questionText.endsWith("_")) { %>
                <input type="text" name="guess<%= i %>"/>
                <% } %>
            </p>
        </div>
        <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE.name())) { %>
        <div class="question-container">
            <h2> Question <%= i + 1 %> </h2>
            <p> <%= questionText %> </p>
            <p> possible answers: </p>
            <%
                List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(question.getQuestionId());
                for (int j = 0; j < possibleAnswers.size(); j++) {
            %>
            <input type="radio" id="ans_<%= i %>_<%= j %>" name="guess<%= i %>" value="<%= possibleAnswers.get(j) %>">
            <label class="answer-label" for="ans_<%= i %>_<%= j %>"> <%= possibleAnswers.get(j) %> </label>
            <br>
             <% } %>
        </div>
        <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())) { %>
        <div class="question-container">
            <h2> Question <%= i + 1 %> </h2>
            <p> <%= questionText %> </p>
            <p> possible answers: </p>
            <%
                List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(question.getQuestionId());
                for (int j = 0; j < possibleAnswers.size(); j++) {
            %>
            <input type="checkbox" id="ans_<%= i %>_<%= j %>" name="guess<%= i %>" value="<%= possibleAnswers.get(j) %>">
            <label class="answer-label" for="ans_<%= i %>_<%= j %>"> <%= possibleAnswers.get(j) %> </label>
            <br>
            <% } %>
        </div>
        <% }
        }
        %>
        <input type="hidden" name="numQuestions" value="<%= questions.size() %>"/>
        <br>
        <input class="fun-button" type="submit" value="Submit All Answers"/>
    </form>
</div>
</body>
</html>
