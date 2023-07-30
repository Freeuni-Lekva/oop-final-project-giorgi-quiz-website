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
import java.util.List;

@WebServlet("/add-friends")
public class AddFriendsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        if(Integer.parseInt(httpServletRequest.getParameter("user_id")) != ((Integer) httpServletRequest.getSession().getAttribute("current_active")).intValue()){
            throw new RuntimeException();
        }
        List<User> users;
        try {
            users = UsersInformation.findAllUsers();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        httpServletRequest.setAttribute("allUsers", users);
        httpServletRequest.getRequestDispatcher("add_friends.jsp").forward(httpServletRequest, httpServletResponse);
    }

}
