package com.example.userloginsystem;

import com.freeuni.quizwebsite.service.manipulation.UsersManipulation;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/create")
public class CreateAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        httpServletRequest.getRequestDispatcher("create_account.jsp").forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String username = httpServletRequest.getParameter("username");
        String firstname = httpServletRequest.getParameter("firstname");
        String lastname = httpServletRequest.getParameter("lastname");
        String password = httpServletRequest.getParameter("password");
        String bio = httpServletRequest.getParameter("bio");

        if (username.trim().length() == 0 || firstname.trim().length() == 0
                || lastname.trim().length() == 0 || password.trim().length() == 0) {
            httpServletRequest.setAttribute("errorMessage", "Invalid username, password or name");
            httpServletRequest.getRequestDispatcher("try_again_create.jsp").forward(httpServletRequest, httpServletResponse);
            return;
        }
        int isAdded = -1;
        try {
            isAdded = UsersManipulation.addUser(firstname, lastname, username, bio, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(isAdded);

        if (isAdded == -1) {
            httpServletRequest.setAttribute("errorMessage", "Username Already Taken");
            httpServletRequest.getRequestDispatcher("try_again_create.jsp").forward(httpServletRequest, httpServletResponse);
            return;
        }

        httpServletResponse.sendRedirect("index.jsp");
    }
}