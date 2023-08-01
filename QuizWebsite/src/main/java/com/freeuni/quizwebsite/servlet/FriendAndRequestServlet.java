package com.freeuni.quizwebsite.servlet;

import com.freeuni.quizwebsite.service.manipulation.FriendRequestManipulation;
import com.freeuni.quizwebsite.service.manipulation.FriendsManipulation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/friend-request")
public class FriendAndRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int profile_id = Integer.parseInt(request.getParameter("profile_id"));
        Integer current_id = (Integer) request.getSession().getAttribute("current_active");
        if(current_id == null) throw new RuntimeException("current_id in null!");
        boolean aboutRequest = Boolean.parseBoolean(request.getParameter("req"));
        boolean isReject = Boolean.parseBoolean(request.getParameter("rej"));
        try {
            if(aboutRequest && isReject) {
                FriendRequestManipulation.deleteFriendRequestByIds(current_id, profile_id);
            } else if (aboutRequest && !isReject) {
                FriendRequestManipulation.addFriendRequestByIds(profile_id, current_id);
            } else if (!aboutRequest && isReject) {
                FriendsManipulation.deleteFriendByIds(current_id, profile_id);
            } else {
                FriendRequestManipulation.deleteFriendRequestByIds(current_id, profile_id);
                FriendsManipulation.addFriendByIds(current_id, profile_id);
            }
        } catch (Exception e) {
            throw new RuntimeException();
        }
        response.sendRedirect( request.getHeader("Referer") );
    }

}
