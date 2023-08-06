package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.Challenge;
import com.freeuni.quizwebsite.service.ChallengesInformation;
import com.freeuni.quizwebsite.service.UsersInformation;
import com.freeuni.quizwebsite.service.manipulation.AnnouncementManipulation;
import com.freeuni.quizwebsite.service.manipulation.ChallengesManipulation;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/challengeUser")
public class ChallengeUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String messageTxt = httpServletRequest.getParameter("message");
        String receiverUsername = httpServletRequest.getParameter("username");
        int currentActive = Integer.parseInt(httpServletRequest.getParameter("current_active"));
        int quizId = Integer.parseInt(httpServletRequest.getParameter("current_quiz"));
        try {
            ChallengesManipulation.addChallenge(currentActive, UsersInformation.findUserByUserName(receiverUsername).getUserId(),quizId,messageTxt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        String redirectUrl = "quiz.jsp?id=" + quizId;
        httpServletResponse.sendRedirect(redirectUrl);
    }
}
