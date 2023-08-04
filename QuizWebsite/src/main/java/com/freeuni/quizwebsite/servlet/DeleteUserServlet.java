package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.service.UsersInformation;
import com.freeuni.quizwebsite.service.manipulation.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer current_id =  (Integer) request.getSession().getAttribute("current_active");
        int profile_id = Integer.parseInt(request.getParameter("profile_id"));
        try {
            if((current_id != profile_id) && (UsersInformation.exceptAdmins()
                                                .contains(UsersInformation.findUserById(current_id)))) {
                throw new RuntimeException("VIGINDARAV!");
            }
            UsersManipulation.deleteUserById(profile_id);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if(current_id == profile_id) {
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("home_page.jsp");
        }
    }

}
