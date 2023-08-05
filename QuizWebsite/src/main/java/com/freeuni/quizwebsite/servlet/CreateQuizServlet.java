package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.service.QuizzesInformation;
import com.freeuni.quizwebsite.service.manipulation.QuestionsManipulation;
import com.freeuni.quizwebsite.service.manipulation.QuizManipulation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/CreateQuiz")
public class CreateQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Collect quiz information from the form
            if (httpServletRequest.getSession().getAttribute("current_active") == null) {
                throw new RuntimeException();
            }
            String userIdStr = httpServletRequest.getSession().getAttribute("current_active").toString();
            if (userIdStr == null || userIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user_id parameter");
                return;
            }
            int userId = Integer.parseInt(userIdStr);
            String name = httpServletRequest.getParameter("quizName");
            String description = httpServletRequest.getParameter("quizDescription");
            String randomQuestionsParam = httpServletRequest.getParameter("randomQuestions");
            boolean randomQuestions = "on".equals(randomQuestionsParam);
            String oneOrMultiplestr = httpServletRequest.getParameter("onePage");
            boolean oneOrMultiple = "on".equals(oneOrMultiplestr);
            boolean instantFeedback = Boolean.parseBoolean(httpServletRequest.getParameter("immediateCorrection"));
            boolean practiceMode = Boolean.parseBoolean(httpServletRequest.getParameter("practiceMode"));
            // Call addQuiz method to add quiz to database
            QuizManipulation.addQuiz(userId, name, description, randomQuestions, oneOrMultiple, instantFeedback, practiceMode, "CREATED", 0);

            // Assume questions, possible answers, and correct answers are passed as arrays
            String[] questions = httpServletRequest.getParameterValues("questions[]");
            String[] questionsTypes = httpServletRequest.getParameterValues("questionTypes[]");
            String[] correctAnswers = httpServletRequest.getParameterValues("answers[]");

            // Call addQuestion, addPossibleAnswer and addCorrectAnswer for each question
            for (int i = 0; i < questions.length; i++) {
                int questionId = QuestionsManipulation.addQuestion(QuizzesInformation.findQuizzesByName(name).get(0).getQuizId(), "", questionsTypes[i], questions[i], i); // Add question to DB and get questionId
            }

            // Redirect to a success page
            response.sendRedirect("home_page.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
