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
                System.out.println("shevida");
                throw new RuntimeException();
            }
            System.out.println("ar ");
            String userIdStr = httpServletRequest.getSession().getAttribute("current_active").toString();
            System.out.println(userIdStr);
            if (userIdStr == null || userIdStr.isEmpty()) {
                System.out.println("shevida2");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user_id parameter");
                return;
            }
            int userId = Integer.parseInt(userIdStr);
            System.out.println(userId);
            String name = httpServletRequest.getParameter("quizName");
            System.out.println(name);
            String description = httpServletRequest.getParameter("description");
            System.out.println(description);
            String randomQuestionsParam = httpServletRequest.getParameter("randomQuestions");
            boolean randomQuestions = "on".equals(randomQuestionsParam);
            System.out.println(randomQuestions);
            String oneOrMultiplestr = httpServletRequest.getParameter("onePage");
            boolean oneOrMultiple = "on".equals(oneOrMultiplestr);
            System.out.println(oneOrMultiple);
            boolean instantFeedback = Boolean.parseBoolean(httpServletRequest.getParameter("immediateCorrection"));
            System.out.println(instantFeedback);
            boolean practiceMode = Boolean.parseBoolean(httpServletRequest.getParameter("practiceMode"));
            System.out.println(practiceMode);
            System.out.println("1");
            // Call addQuiz method to add quiz to database
            QuizManipulation.addQuiz(userId, name, description, randomQuestions, oneOrMultiple, instantFeedback, practiceMode, "CREATED", 0);

            // Assume questions, possible answers, and correct answers are passed as arrays
            String[] questions = httpServletRequest.getParameterValues("questions[]");
            String[] possibleAnswers = httpServletRequest.getParameterValues("possibleAnswers");
            String[] correctAnswers = httpServletRequest.getParameterValues("correctAnswers");

            // Call addQuestion, addPossibleAnswer and addCorrectAnswer for each question
            for (int i = 0; i < questions.length; i++) {
                int questionId = QuestionsManipulation.addQuestion(QuizzesInformation.findQuizzesByName(name).get(0).getQuizId(), "", "questionType", questions[i], i); // Add question to DB and get questionId
                QuestionsManipulation.addPossibleAnswer(questionId, possibleAnswers[i]); // Add possible answer to DB
                QuestionsManipulation.addCorrectAnswer(questionId, correctAnswers[i]); // Add correct answer to DB
            }

            // Redirect to a success page
            response.sendRedirect("home_page.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception - could redirect to an error page
        }
    }
}
