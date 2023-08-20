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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.stream.Collectors;

@WebServlet("/transition")
public class PageTransitionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cnt = (int) req.getSession().getAttribute("queue");
        ArrayList<Question> questions = (ArrayList<Question>) req.getSession().getAttribute("questions");
        HashMap<Integer, ArrayList<String> > answers = (HashMap<Integer, ArrayList<String>>) req.getSession().getAttribute("answers");

        String lastOnesType = questions.get(cnt-1).getQuestionType();

        if(lastOnesType.equals("MULTIPLE_CHOICE") || lastOnesType.equals("QUESTION_RESPONSE")|| lastOnesType.equals("PICTURE_RESPONSE")) {
            ArrayList<String> recreateGuess = new ArrayList<>();
            String currentAns = req.getParameter("guess" + (cnt-1));
            if(currentAns == null || currentAns.equals("")) currentAns = "";
            recreateGuess.add(currentAns);
            answers.put(questions.get(cnt-1).getQuestionId(), recreateGuess);

        } else if(lastOnesType.equals("FILL_IN_BLANK")) {

            String[] checked = req.getParameterValues("guess"+(cnt-1));
            if(checked!=null) {
                ArrayList<String> asList = (ArrayList<String>) Arrays.stream(checked).filter(e->!e.isEmpty()).collect(Collectors.toList());
                if(asList.size()!=0) answers.put(questions.get(cnt-1).getQuestionId(), asList);
                else answers.put(questions.get(cnt-1).getQuestionId(), null);
            } else answers.put(questions.get(cnt-1).getQuestionId(), null);


        } else if(lastOnesType.equals("QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED") || lastOnesType.equals("QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED") || lastOnesType.equals("MULTIPLE_CHOICE_MULTIPLE_ANSWER")){
            String[] checked = req.getParameterValues("guess"+(cnt-1));
            ArrayList<String> asList = null;
            if(checked != null) {
                asList = (ArrayList<String>) Arrays.stream(checked).filter(e->!e.isEmpty()).collect(Collectors.toList());
            }
            answers.put(questions.get(cnt-1).getQuestionId(), asList);
        }
        req.getSession().setAttribute("answers", answers);

        if(cnt==questions.size()) {
            HashMap<Integer, String> resultPerQuestion = new HashMap<>();
            int result = 0;

            for (Integer questionId: answers.keySet()) {
                try {

                    int before = result;
                    Question question = QuestionInformation.getQuestion(questionId);
                    ArrayList<String> answered = answers.get(questionId);
                    ArrayList<String> correctAnswers = (ArrayList<String>) QuestionInformation.getCorrectAnswers(questionId);
                    String questionType = question.getQuestionType();

                    if (questionType.equals(QuestionType.MULTIPLE_CHOICE_MULTIPLE_ANSWER.name())
                            || questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED.name())) {

                        if (answered!=null && answered.containsAll(correctAnswers) && correctAnswers.containsAll(answered)) result++;

                    } else if (questionType.equals(QuestionType.QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED.name())
                            || questionType.equals(QuestionType.FILL_IN_BLANK.name())) {

                        if (answered!=null && answered.equals(correctAnswers)) result++;

                    } else {
                        String currentAnswer = "";
                        if(answered!=null) currentAnswer = answered.get(0);
                        if (correctAnswers.contains(currentAnswer)) result++;
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
            }
            if(req.getSession().getAttribute("is-practice") == null) {
                try {
                    QuizHistoryManipulation.addQuizHistory((int) req.getSession().getAttribute("current_active"), questions.get(0).getQuizId(), result);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            req.getSession().setAttribute("result", result);
            req.getSession().setAttribute("resultAns", resultPerQuestion);
            req.getRequestDispatcher("quiz_result.jsp").forward(req, resp);
        } else {
            String type = questions.get(cnt).getQuestionType();
            if(type.equals("MULTIPLE_CHOICE")) req.getRequestDispatcher("multiple_choice.jsp").forward(req,resp);
            else if(type.equals("QUESTION_RESPONSE")) req.getRequestDispatcher("question_response.jsp").forward(req, resp);
            else if(type.equals("MULTIPLE_CHOICE_MULTIPLE_ANSWER")) req.getRequestDispatcher("multiple_choice_multiple_answer.jsp").forward(req, resp);
            else if(type.equals("QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED") || type.equals("QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED")) req.getRequestDispatcher("question_response_multiple_answer.jsp").forward(req, resp);
            else if(type.equals("FILL_IN_BLANK")) req.getRequestDispatcher("fill_in_blank.jsp").forward(req, resp);
            else if(type.equals("PICTURE_RESPONSE")) req.getRequestDispatcher("picture_response.jsp").forward(req, resp);
        }

    }
}
