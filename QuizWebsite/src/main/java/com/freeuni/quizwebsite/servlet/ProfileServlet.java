package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.User;
import com.freeuni.quizwebsite.service.UsersInformation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int profileId = Integer.parseInt(request.getParameter("user_id"));
        Integer currentId = (Integer) request.getSession().getAttribute("current_active");
        try {
            User currentUser = UsersInformation.findUserById(currentId);
            request.setAttribute("currentUser", currentUser);
            request.setAttribute("profileInfo", UsersInformation.findUserById(profileId));

            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
