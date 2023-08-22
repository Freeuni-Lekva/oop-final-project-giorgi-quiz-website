package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.Quiz;
import com.freeuni.quizwebsite.model.db.User;
import com.freeuni.quizwebsite.service.QuizzesInformation;
import com.freeuni.quizwebsite.service.UsersInformation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search-results")
public class SearchQuizServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        List<Quiz> allAlikequizzes;
        List<Quiz> limitedAlikequizzes;
        List<User> allUsers;
        List<User> alikeUsers = new ArrayList<>();
        String searchingFor = httpServletRequest.getParameter("search-input").toLowerCase();
        try { //yvelaferi lowercaseshia?
            allAlikequizzes = QuizzesInformation.findQuizzesByName(searchingFor);
            allUsers = UsersInformation.findAllUsers();
            int quizNum = allAlikequizzes.size();
            int userAllowedNum = 5;
            if(quizNum > 5) {
                limitedAlikequizzes = new ArrayList<>();
                for (int i = 0; i < 5; i++) {
                    limitedAlikequizzes.add(allAlikequizzes.get(i));
                }
            } else limitedAlikequizzes = allAlikequizzes;
            if(quizNum < 5) userAllowedNum+=5-quizNum;
//            if(searchingFor!="") {
                int cnt = 0;
                for (User user: allUsers) {
                    if(cnt < 5) {
                        if(searchingFor=="" || user.getUsername().toLowerCase().contains(searchingFor)) {
                            alikeUsers.add(user);
                            cnt++;
                        }
                    }
                }
//            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        httpServletRequest.setAttribute("Quizzes", limitedAlikequizzes);
        httpServletRequest.setAttribute("Users", alikeUsers);
        httpServletRequest.getRequestDispatcher("search_results.jsp").forward(httpServletRequest, httpServletResponse);
    }
}
