package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.service.UsersInformation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/checkUsernameValidity")
public class CheckUsernameValidityServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        boolean isValid;
        try {
            isValid = UsersInformation.isUsernameValid(username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.valueOf(isValid));
    }
}