<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.model.QuestionType" %>
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
    </style>

    <script>
        function addTextField(guessIdx) {
            const container = document.getElementById("question"+guessIdx);
            const newTextField = document.createElement("input");
            newTextField.type = "text";
            newTextField.name = "guess"+guessIdx;
            container.appendChild(document.createElement("br"));
            container.appendChild(newTextField);
        }
    </script>
</head>
<body>

<h1>Quiz ID: <%= quizId %>
</h1>
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
    <div id="question<%= i %>">
        <p> <%= questionText %> </p>
        <input type="text" name="guess<%= i %>"/>
        <% if (question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())
                || question.getQuestionType().equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())) { %>
        <button type="button" onclick="addTextField(<%= i %>)">Add New Text Field</button>
        <% } %>
    </div>
    <% } else if (question.getQuestionType().equals(QuestionType.PICTURE_RESPONSE.name())) { %>
    <div>
        <p> <%= questionText %> </p>
        <img src="<%=question.getPicURL()%>" alt="pic for question <%= i + 1 %>" width="500" height="600">
        <br>
        <input type="text" name="guess<%= i %>"/>
    </div>
    <% } else if (question.getQuestionType().equals(QuestionType.FILL_IN_BLANK.name())) { %>
    <div>
        <p> Fill in the blanks: </p>
        <p> <%= questionText %> </p>
        <input type="text" name="guess<%= i %>"/>
    </div>
    <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE.name())) { %>
    <div>
        <p> <%= questionText %> </p>
        <p> possible answers: </p>
        <%
            List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(question.getQuestionId());
            for (int j = 0; j < possibleAnswers.size(); j++) {
        %>
        <input type="radio" id="ans_<%= i %>_<%= j %>" name="guess<%= i %>" value="<%= possibleAnswers.get(j) %>">
        <label for="ans_<%= i %>_<%= j %>"> <%= possibleAnswers.get(j) %> </label>
        <br>
         <% } %>
    </div>
    <% } else if (question.getQuestionType().equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())) { %>
    <div>
        <p> <%= questionText %> </p>
        <p> possible answers: </p>
        <%
            List<String> possibleAnswers = QuestionInformation.getPossibleAnswers(question.getQuestionId());
            for (int j = 0; j < possibleAnswers.size(); j++) {
        %>
        <input type="checkbox" id="ans_<%= i %>_<%= j %>" name="guess<%= i %>" value="<%= possibleAnswers.get(j) %>">
        <label for="ans_<%= i %>_<%= j %>"> <%= possibleAnswers.get(j) %> </label>
        <br>
        <% } %>
    </div>
    <% }
    }
    %>
    <input type="hidden" name="numQuestions" value="<%= questions.size() %>"/>
    <br>
    <input type="submit" value="Submit All Answers"/>
</form>
</body>
</html>
