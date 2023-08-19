package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.QuestionType;
import com.freeuni.quizwebsite.model.db.Question;
import com.freeuni.quizwebsite.service.QuestionInformation;
import com.freeuni.quizwebsite.service.manipulation.QuizHistoryManipulation;
import jakarta.servlet.ServletException;
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
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        // Get the number of questions
        int numQuestions = Integer.parseInt(httpServletRequest.getParameter("numQuestions"));
        HashMap<Integer, ArrayList<String> > questionAndAnswersMap = new HashMap<>();

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
                List<String> asList = null;
                if(checked != null) {
                    asList = Arrays.stream(checked).filter(e->!e.isEmpty()).collect(Collectors.toList());
                    if(asList.size()==0) asList = null;
                }
                questionAndAnswersMap.put(questionId, (ArrayList<String>) asList);
            } else {
                String answerText = httpServletRequest.getParameter("guess" + i);
                questionAndAnswersMap.put(questionId, new ArrayList<>());
                questionAndAnswersMap.get(questionId).add(answerText);
            }
        }
        HashMap<Integer, String> resultPerQuestion = new HashMap<>();
        int result = 0;
        int quizId = 0;
        for (Integer questionId : questionAndAnswersMap.keySet()) {
            try {
                int before = result;
                Question question = QuestionInformation.getQuestion(questionId);
                List<String> answered = questionAndAnswersMap.get(questionId);
                List<String> correctAnswers = QuestionInformation.getCorrectAnswers(questionId);
                String questionType = question.getQuestionType();
                System.out.println("correct: " + correctAnswers);
                System.out.println("your guess: " + answered);
                if(questionType.equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())
                        || questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())) {
                    System.out.println(correctAnswers.size());
                    if(answered!= null && answered.size() == correctAnswers.size() && correctAnswers.containsAll(answered)) {
                        System.out.println("CORRECT!");
                        result++;
                    } else {
                        System.out.println("WRONG!");
                    }
                } else if (questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())
                        || questionType.equals(QuestionType.FILL_IN_BLANK.name())) {
                    if(answered!= null && answered.equals(correctAnswers)) {
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
                String ans = "Wrong!";
                if(result-before==0) resultPerQuestion.put(questionId, ans);
                else {
                    ans = "Correct!";
                    resultPerQuestion.put(questionId, ans);
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if(quizId==0) {
                try {
                    quizId = QuestionInformation.getQuestion(questionId).getQuizId();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        try {
            QuizHistoryManipulation.addQuizHistory((int)httpServletRequest.getSession().getAttribute("current_active"), quizId, result);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        httpServletRequest.getSession().setAttribute("quizId", quizId);
        httpServletRequest.getSession().setAttribute("result", result);
        httpServletRequest.getSession().setAttribute("resultAns", resultPerQuestion);
        httpServletRequest.getSession().setAttribute("answers", questionAndAnswersMap);
        httpServletRequest.getRequestDispatcher("quiz_result.jsp").forward(httpServletRequest, httpServletResponse);
    }
}
