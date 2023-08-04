package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.Challenge;
import com.freeuni.quizwebsite.service.ChallengesInformation;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/challenges")
public class ChallengesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        if (httpServletRequest.getSession().getAttribute("current_active") == null) {
            throw new RuntimeException();
        }

        if(Integer.parseInt(httpServletRequest.getParameter("user_id")) != ((Integer) httpServletRequest.getSession().getAttribute("current_active")).intValue()){
            throw new RuntimeException();
        }
        int userId = Integer.parseInt(httpServletRequest.getParameter("user_id"));
        List<Challenge> challenges;
        try {
            challenges = ChallengesInformation.getUserReceivedChallenges(userId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        httpServletRequest.setAttribute("challenges", challenges);
        httpServletRequest.getRequestDispatcher("challenges.jsp").forward(httpServletRequest, httpServletResponse);
    }
}
