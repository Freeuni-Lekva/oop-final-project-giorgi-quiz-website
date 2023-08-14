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
        if(httpServletRequest.getSession().getAttribute("current_active") == null) {
            httpServletRequest.setAttribute("not-logged", new Object());
            httpServletRequest.getRequestDispatcher("index.jsp").forward(httpServletRequest, httpServletResponse);
        }
        Integer currentUserId = (Integer) httpServletRequest.getSession().getAttribute("current_active");

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
