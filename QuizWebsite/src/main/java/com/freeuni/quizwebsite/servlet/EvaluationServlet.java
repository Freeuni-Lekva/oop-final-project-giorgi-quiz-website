package com.freeuni.quizwebsite.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/evaluation")
public class EvaluationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
        // Get the number of questions
        int numQuestions = Integer.parseInt(httpServletRequest.getParameter("numQuestions"));

        // Loop through each question and print the question ID and answer text
        for (int i = 0; i < numQuestions; i++) {
            String questionId = httpServletRequest.getParameter("questionId" + i);
            String answerText = httpServletRequest.getParameter("guess" + i);
            System.out.println("Question ID: " + questionId + ", guess: " + answerText);
        }

    }
}
