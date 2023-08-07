<%@ page import="com.freeuni.quizwebsite.model.db.Question" %>
<%@ page import="com.freeuni.quizwebsite.service.QuestionInformation" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Questions</title>
</head>
<body>
<%
    String quizId = request.getParameter("id");
    List<Question> questions = QuestionInformation.getQuestionsInQuiz(Integer.parseInt(quizId));
%>
<h1>Quiz ID: <%= quizId %></h1>
<form action="evaluation" method="post">
    <%
        for (int i = 0; i < questions.size(); i++) {
            Question question = questions.get(i);
            String questionText = question.getQuestion();
    %>
    <div>
        <h2>Question <%= i + 1 %></h2>
        <p><%= questionText %></p>
        <input type="hidden" name="questionId<%= i %>" value="<%= question.getQuestionId() %>" />
        <input type="text" name="guess<%= i %>" />
        <input type="hidden" name="numQuestions" value="<%= questions.size() %>" />
    </div>
    <%
        }
    %>
    <input type="submit" value="Submit All Answers" />
</form>
</body>
</html>
