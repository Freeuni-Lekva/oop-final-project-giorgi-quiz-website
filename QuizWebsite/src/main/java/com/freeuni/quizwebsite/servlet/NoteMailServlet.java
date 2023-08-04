package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.model.db.NoteMail;
import com.freeuni.quizwebsite.service.NoteMailInformation;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/note_Mail")
public class NoteMailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {


        if (httpServletRequest.getSession().getAttribute("current_active") == null) {
            throw new RuntimeException();
        }
        if(Integer.parseInt(httpServletRequest.getParameter("user_id")) != ((Integer) httpServletRequest.getSession().getAttribute("current_active")).intValue()){
            throw new RuntimeException();
        }
        int userId = Integer.parseInt(httpServletRequest.getParameter("user_id"));
        List<NoteMail> recive;
        List<NoteMail> sent;
        // ...
        try {
            recive = NoteMailInformation.getUserReceivedNotes(userId);
            sent = NoteMailInformation.getUserSentNotes(userId);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        httpServletRequest.setAttribute("received", recive);
        httpServletRequest.setAttribute("sent",sent);
        httpServletRequest.getRequestDispatcher("note_Mail.jsp").forward(httpServletRequest, httpServletResponse);
// ...
    }
}
