package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.Question;
import com.freeuni.quizwebsite.service.QuestionInformation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/evaluation")
public class EvaluationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
        // Get the number of questions
        int numQuestions = Integer.parseInt(httpServletRequest.getParameter("numQuestions"));
        Map<Integer,String> questionAndAnswersMap = new HashMap<>();
        List<Integer> questionsIds = new ArrayList<>();
        int result;

        // Loop through each question and print the question ID and answer text
        for (int i = 0; i < numQuestions; i++) {
            Integer questionId = Integer.valueOf(httpServletRequest.getParameter("questionId" + i));
            String answerText = httpServletRequest.getParameter("guess" + i);
            questionAndAnswersMap.put(questionId,answerText);
            questionsIds.add(questionId);
        }
        System.out.println(questionAndAnswersMap);

        for (int i = 0; i <questionsIds.size() ; i++) {
            Integer id = questionsIds.get(i);
            Question question;
//            List<An>
            try {
                question = QuestionInformation.getQuestion(id);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if(question.getQuestionType()=="QUESTION_RESPONSE"){

            }

        }

    }
}
