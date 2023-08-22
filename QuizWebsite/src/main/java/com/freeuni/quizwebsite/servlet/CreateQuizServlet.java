package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.QuestionType;
import com.freeuni.quizwebsite.service.QuizzesInformation;
import com.freeuni.quizwebsite.service.manipulation.AchievementsManipulation;
import com.freeuni.quizwebsite.service.manipulation.QuestionsManipulation;
import com.freeuni.quizwebsite.service.manipulation.QuizManipulation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/CreateQuiz")
public class CreateQuizServlet extends HttpServlet {
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Collect quiz information from the form
            if (httpServletRequest.getSession().getAttribute("current_active") == null) {
                httpServletRequest.setAttribute("not-logged", new Object());
                httpServletRequest.getRequestDispatcher("index.jsp").forward(httpServletRequest, response);
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
            boolean oneOrMultiple = !("on".equals(oneOrMultiplestr));
            String immediateCorrectionStr = httpServletRequest.getParameter("immediateCorrection");
            boolean instantFeedback = "on".equals(immediateCorrectionStr);
            String practiceModeStr = httpServletRequest.getParameter("practiceMode");
            boolean practiceMode = "on".equals(practiceModeStr);
            // Call addQuiz method to add quiz to database
            int quizId = QuizManipulation.addQuiz(userId, name, description, randomQuestions, oneOrMultiple, instantFeedback, practiceMode, "PUBLISHED", 0);

            String[] questions = httpServletRequest.getParameterValues("questions[]");
            String[] questionsTypes = httpServletRequest.getParameterValues("questionTypes[]");
            ArrayList<ArrayList<Boolean>> correctMatrix = new ArrayList<>();
            String argument = httpServletRequest.getParameter("argument");
            for (int i = 0; i < 2000; i++) {
                String[] curr;
                try {
                    curr = httpServletRequest.getParameterValues("answers[" + i + "][]");
                } catch (Exception e) {
                    break;
                }

                String[] correct = httpServletRequest.getParameterValues("correctAnswers[" + i + "][]");
                if (curr == null) {
                    continue;
                }

                if (correct != null) {
                    ArrayList<Boolean> curCorrect = new ArrayList<>();
                    for (int j = 0; j < correct.length - 1; j++) {
                        if (correct[j + 1].equals("on") && correct[j].equals("off")) {
                            curCorrect.add(true);
                            j++;
                        } else {
                            curCorrect.add(false);
                        }
                    }
                    if (correct[correct.length - 1].equals("off")) {
                        curCorrect.add(false);
                    }
                    correctMatrix.add(curCorrect);
                }

                System.out.println(Arrays.toString(curr));

            }

            String tags = httpServletRequest.getParameter("quizTags");
            List<String> tagsList = Arrays.asList(tags.split("\\s*,\\s*"));
            for (String tag : tagsList) {
                QuizManipulation.addTagsToQuiz(quizId, tag);
            }

            String[] urls = httpServletRequest.getParameterValues("pictureUrls[]");
            int j = 0;
            int k = 0;
            int m = 0;

            for (int i = 0; i < questions.length; i++) {

                if (questionsTypes[i].equals(QuestionType.PICTURE_RESPONSE.name())) {
                    int questionId = QuestionsManipulation.addQuestion(quizId,
                            urls[j], questionsTypes[i], questions[i], i); // Add question to DB and get questionId
                    j++;
                    String[] curr;
                    while(true){
                        curr = httpServletRequest.getParameterValues("answers[" + (m) + "][]");
                        m++;
                        if(curr != null) break;
                    }

                    for (String answer : curr) {
                        QuestionsManipulation.addCorrectAnswer(questionId, answer);
                    }
                } else {
                    int questionId = QuestionsManipulation.addQuestion(quizId,
                            "", questionsTypes[i], questions[i], i); // Add question to DB and get questionId
                    String[] curr;
                    while(true){
                        curr = httpServletRequest.getParameterValues("answers[" + (m) + "][]");
                        m++;
                        if(curr != null) break;
                    }
                    if(questionsTypes[i].equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())
                            ||questionsTypes[i].equals(QuestionType.MULTIPLE_CHOICE.name())){
                        for (String answer : curr) {
                            QuestionsManipulation.addPossibleAnswer(questionId, answer);
                        }
                        ArrayList<Boolean> currAnswers = correctMatrix.get(k);
                        for(int l = 0; l < curr.length; l++){
                            if(currAnswers.get(l)){
                                QuestionsManipulation.addCorrectAnswer(questionId, curr[l]);
                            }
                        }
                        k++;
                    }else {
                        for (String answer : curr) {
                            QuestionsManipulation.addCorrectAnswer(questionId, answer);
                        }
                    }
                }
            }

            switch (QuizzesInformation.findQuizzesByUserId(userId).size()){
                case 1:
                    AchievementsManipulation.addAchievement(userId,"AMATEUR_AUTHOR");
                    break;
                case 5:
                    AchievementsManipulation.addAchievement(userId,"PROLIFIC_AUTHOR");
                    break;
                case 10:
                    AchievementsManipulation.addAchievement(userId,"PRODIGIOUS_AUTHOR");
                    break;

            }

            // Redirect to a success page
            response.sendRedirect("home_page.jsp");



        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
