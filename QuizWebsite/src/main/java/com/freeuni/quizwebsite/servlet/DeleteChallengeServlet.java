package com.freeuni.quizwebsite.servlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.freeuni.quizwebsite.service.manipulation.ChallengesManipulation.deleteChallengeById;

@WebServlet("/deleteChallenge")
public class DeleteChallengeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {
        try {
            int challengeId = Integer.parseInt(httpServletRequest.getParameter("challengeId"));
            // Call your delete method here
            deleteChallengeById(challengeId);
            httpServletResponse.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            httpServletResponse.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
