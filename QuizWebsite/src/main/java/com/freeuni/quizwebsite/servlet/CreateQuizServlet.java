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
            boolean sorted = !Boolean.parseBoolean(httpServletRequest.getParameter("randomQuestions"));
            System.out.println(sorted);
            boolean oneOrMultiple = Boolean.parseBoolean(httpServletRequest.getParameter("onePage"));
            System.out.println(oneOrMultiple);
            boolean instantFeedback = Boolean.parseBoolean(httpServletRequest.getParameter("immediateCorrection"));
            System.out.println(instantFeedback);
            boolean practiceMode = Boolean.parseBoolean(httpServletRequest.getParameter("practiceMode"));
            System.out.println(practiceMode);
            String quizStates = httpServletRequest.getParameter("quizStates");
            System.out.println(quizStates);
            int viewCount = Integer.parseInt(httpServletRequest.getParameter("viewCount"));
            System.out.println(viewCount);

            // Call addQuiz method to add quiz to database
            QuizManipulation.addQuiz(userId, name, description, sorted, oneOrMultiple, instantFeedback, practiceMode, quizStates, viewCount);

            // Assume questions, possible answers, and correct answers are passed as arrays
            String[] questions = httpServletRequest.getParameterValues("questions");
            String[] possibleAnswers = httpServletRequest.getParameterValues("possibleAnswers");
            String[] correctAnswers = httpServletRequest.getParameterValues("correctAnswers");

            // Call addQuestion, addPossibleAnswer and addCorrectAnswer for each question
            for (int i = 0; i < questions.length; i++) {
                int questionId = QuestionsManipulation.addQuestion(QuizzesInformation.findQuizzesByName(name).get(0).getQuizId(), "", "questionType", questions[i], i); // Add question to DB and get questionId
                QuestionsManipulation.addPossibleAnswer(questionId, possibleAnswers[i]); // Add possible answer to DB
                QuestionsManipulation.addCorrectAnswer(questionId, correctAnswers[i]); // Add correct answer to DB
            }

            // Redirect to a success page
            response.sendRedirect("quizCreationSuccess.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception - could redirect to an error page
        }
    }
}
