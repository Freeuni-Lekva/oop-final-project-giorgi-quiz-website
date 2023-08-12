package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.QuestionType;
import com.freeuni.quizwebsite.model.db.Question;
import com.freeuni.quizwebsite.service.QuestionInformation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/evaluation")
public class EvaluationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
        // Get the number of questions
        int numQuestions = Integer.parseInt(httpServletRequest.getParameter("numQuestions"));
        Map<Integer, List<String> > questionAndAnswersMap = new HashMap<>();

        // Loop through each question and print the question ID and answer text
        for (int i = 0; i < numQuestions; i++) {
            Integer questionId = Integer.valueOf(httpServletRequest.getParameter("questionId" + i));
            Question question;
            try {
                question = QuestionInformation.getQuestion(questionId);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            String questionType = question.getQuestionType();
            if (questionType.equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())
                || questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())
                    || questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())
                        || questionType.equals(QuestionType.FILL_IN_BLANK.name())) {
                String[] checked = httpServletRequest.getParameterValues("guess"+i);
                if(checked == null) {
                    continue;
                }
                List<String> aslist = Arrays.stream(checked).filter(e->!e.isEmpty()).collect(Collectors.toList());
                questionAndAnswersMap.put(questionId, aslist);
            } else {
                String answerText = httpServletRequest.getParameter("guess" + i);
                questionAndAnswersMap.put(questionId, new ArrayList<>());
                questionAndAnswersMap.get(questionId).add(answerText);
            }
        }

        int result = 0;
        for (Integer questionId : questionAndAnswersMap.keySet()) {
            System.out.println(questionId);
            try {
                Question question = QuestionInformation.getQuestion(questionId);
                List<String> answered = questionAndAnswersMap.get(questionId);
                List<String> correctAnswers = QuestionInformation.getCorrectAnswers(questionId);
                String questionType = question.getQuestionType();
                System.out.println("correct: " + correctAnswers);
                System.out.println("your guess: " + answered);
                if(questionType.equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())
                        || questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())) {
                    System.out.println(correctAnswers.size());
                    if(answered.size() == correctAnswers.size() && correctAnswers.containsAll(answered)) {
                        System.out.println("CORRECT!");
                        result++;
                    } else {
                        System.out.println("WRONG!");
                    }
                } else if (questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())) {
                    if(answered.equals(correctAnswers)) {
                        System.out.println("CORRECT!");
                        result++;
                    } else {
                        System.out.println("WRONG!");
                    }
                } else {
                    String currentAnswer = answered.get(0);
                    if (correctAnswers.contains(currentAnswer)) {
                        System.out.println("CORRECT!");
                        result++;
                    } else {
                        System.out.println("WRONG!");
                    }
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
