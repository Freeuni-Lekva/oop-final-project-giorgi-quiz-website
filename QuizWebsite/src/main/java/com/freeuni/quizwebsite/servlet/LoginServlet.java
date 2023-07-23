package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.User;
import com.freeuni.quizwebsite.service.UsersInformation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        httpServletRequest.getRequestDispatcher("login.jsp").forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String username = httpServletRequest.getParameter("username");
        String password = httpServletRequest.getParameter("password");
        User user;
        try {
            user = UsersInformation.findUserByUserName(username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (user == null) {
            httpServletRequest.setAttribute("errorMessage", "No Such Username");
            httpServletRequest.getRequestDispatcher("login_try_again.jsp").forward(httpServletRequest, httpServletResponse);
            return;
        }

        int id = user.getUserId();
        try {
            if (!UsersInformation.verifyPassword(id, password)){
                httpServletRequest.setAttribute("errorMessage", "Incorrect Password");
                httpServletRequest.getRequestDispatcher("login_try_again.jsp").forward(httpServletRequest, httpServletResponse);
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        HttpSession httpSession = httpServletRequest.getSession();
        httpSession.setAttribute("current_active", id);
        httpServletResponse.sendRedirect("home_page.jsp");
    }
}