package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.service.UsersInformation;
import com.freeuni.quizwebsite.service.manipulation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete-quiz")
public class DeleteQuizServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int quizId = Integer.parseInt(request.getParameter("quiz_id"));
        try {
            QuizManipulation.deleteQuizByQuizId(quizId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        String redirectUrl = "home_page.jsp";
        response.sendRedirect(redirectUrl);
    }

}
