package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.Question;
import com.freeuni.quizwebsite.service.QuestionInformation;
import com.freeuni.quizwebsite.service.QuizzesInformation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

@WebServlet("/displayQuiz")
public class QuizDisplayServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        clearSessionAttributes(req.getSession());
        boolean singlePage;
        int quizId = Integer.parseInt(req.getParameter("id"));
        try {
            singlePage = QuizzesInformation.findQuizById(quizId).isOneOrMultiple();
            if (req.getParameter("is-practice") != null) {
                req.getSession().setAttribute("is-practice", new Object());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if(!singlePage) req.getRequestDispatcher("start_quiz.jsp").forward(req, resp);
        else {
            try {
                ArrayList<Question> questions = (ArrayList<Question>) QuestionInformation.getQuestionsInQuiz(quizId);
                if(! QuizzesInformation.findQuizById(quizId).isSorted()) {
                    Collections.shuffle(questions);
                }
                HashMap<Integer, ArrayList<String> > answers = new HashMap<>();
                int cnt = 0;
                req.getSession().setAttribute("queue", cnt);
                req.getSession().setAttribute("questions", questions);
                req.getSession().setAttribute("answers", answers);
                req.getSession().setAttribute("quizId", quizId);

                String type = questions.get(cnt).getQuestionType();

                if(type.equals("QUESTION_RESPONSE")) req.getRequestDispatcher("question_response.jsp").forward(req, resp);
                else if(type.equals("MULTIPLE_CHOICE")) req.getRequestDispatcher("multiple_choice.jsp").forward(req,resp);
                else if(type.equals("MULTIPLE_CHOICE_MULTIPLE_ANSWER")) req.getRequestDispatcher("multiple_choice_multiple_answer.jsp").forward(req, resp);
                else if(type.equals("QUESTION_RESPONSE_MULTIPLE_ANSWER_UNORDERED") || type.equals("QUESTION_RESPONSE_MULTIPLE_ANSWER_ORDERED")) req.getRequestDispatcher("question_response_multiple_answer.jsp").forward(req, resp);
                else if(type.equals("FILL_IN_BLANK")) req.getRequestDispatcher("fill_in_blank.jsp").forward(req, resp);
                else if(type.equals("PICTURE_RESPONSE")) req.getRequestDispatcher("picture_response.jsp").forward(req, resp);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void clearSessionAttributes(HttpSession session) {
        session.setAttribute("is-practice", null);
        session.setAttribute("queue", null);
        session.setAttribute("questions", null);
        session.setAttribute("answers", null);
        session.setAttribute("quizId", null);
    }
}
