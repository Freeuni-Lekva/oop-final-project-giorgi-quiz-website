package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.User;
import com.freeuni.quizwebsite.service.UsersInformation;
import com.freeuni.quizwebsite.service.manipulation.AnnouncementManipulation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/doAnnouncement")
public class AddAnnouncement extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String announcementText = httpServletRequest.getParameter("announcement-text");
        int currentActive = Integer.parseInt(httpServletRequest.getParameter("current_active"));

        try {
            AnnouncementManipulation.addAnnouncement(currentActive,announcementText);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        httpServletResponse.sendRedirect("home_page.jsp");
    }
}
