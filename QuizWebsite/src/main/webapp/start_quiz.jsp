<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.model.QuestionType" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="com.freeuni.quizwebsite.service.QuizzesInformation" %>
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
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333333;
        }

        .quiz-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .question-container {
            border: 1px solid #cccccc;
            border-radius: 4px;
            padding: 15px;
            margin-bottom: 10px;
        }

        .question-text {
            font-size: 18px;
            margin-bottom: 10px;
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

        .add-field-button {
            background-color: #007bff;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 5px;
        }

        .add-field-button:hover {
            background-color: #0056b3;
        }

        .submit-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        .submit-button:hover {
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

<h1> <%= QuizzesInformation.findQuizById(quizId).getName() %> </h1>
<div class="quiz-container">
    <form action="evaluation" method="post">
        <%
            List<Question> questions = QuestionInformation.getQuestionsInQuiz(quizId);
            for (int i = 0; i < questions.size(); i++) {
                Question question = questions.get(i);
                String questionText = question.getQuestion();
        %>
        <h2> Question <%= i + 1 %> </h2>
        <input type="hidden" name="questionId<%= i %>" value="<%= question.getQuestionId() %>"/>
        <% if (question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE.name())
            || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())
                || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())) { %>
        <div class="question-container" id="question<%= i %>">
            <p class="question-text"> <%= questionText %> </p>
            <div class="answer-container" id="text-field_question<%= i %>">
                <input class="answer-input" type="text" name="guess<%= i %>"/>
            </div>
            <% if (question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())
                    || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())) { %>
            <button class="add-field-button" type="button" onclick="addTextField(<%= i %>)">Add New Text Field</button>
            <% } %>
        </div>
        <% } else if (question.getQuestionType().equals(QuestionType.PICTURE_RESPONSE.name())) { %>
        <div class="question-container">
            <p> <%= questionText %> </p>
            <img src="<%=question.getPicURL()%>" alt="pic for question <%= i + 1 %>" width="500" height="600">
            <br>
            <input class="answer-input" type="text" name="guess<%= i %>"/>
        </div>
        <% } else if (question.getQuestionType().equals(QuestionType.FILL_IN_BLANK.name())) {
                StringTokenizer questionTokens = new StringTokenizer(questionText, "_");
        %>
        <div class="question-container">
            <p> Fill in the blanks: </p>
            <p><%=questionTokens.nextToken()%>
            <%while (questionTokens.hasMoreTokens()) { %>
            <input type="text" name="guess<%= i %>"/><%=questionTokens.nextToken()%>
            <% } %>
            </p>
        </div>
        <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE.name())) { %>
        <div class="question-container">
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
        <input class="submit-button" type="submit" value="Submit All Answers"/>
    </form>
</div>
</body>
</html>
