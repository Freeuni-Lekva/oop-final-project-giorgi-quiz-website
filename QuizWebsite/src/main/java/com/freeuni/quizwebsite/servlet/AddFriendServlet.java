package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.service.manipulation.FriendRequestManipulation;
import com.freeuni.quizwebsite.service.manipulation.FriendsManipulation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/add-friend")
public class AddFriendServlet extends HttpServlet {

    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        // Get the current active user_id from the session
        Integer currentUserId = (Integer) httpServletRequest.getSession().getAttribute("current_active");
        if (currentUserId == null) {
            httpServletResponse.sendRedirect("login"); // Replace 'login' with the actual login page URL
            return;
        }

        String friendIdString = httpServletRequest.getParameter("user_id");
        if (friendIdString == null || friendIdString.isEmpty()) {
            httpServletResponse.sendRedirect("add-friends");
            return;
        }
        try {
            FriendRequestManipulation.addFriendRequestByIds(currentUserId, Integer.parseInt(friendIdString));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        httpServletResponse.sendRedirect("add-friends");
    }
}
