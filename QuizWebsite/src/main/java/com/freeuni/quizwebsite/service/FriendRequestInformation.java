package com.freeuni.quizwebsite.service;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.FriendRequest;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FriendRequestInformation {

    private static final Connection connection = ConnectToDB.getConnection();

    //returns unordered friendRequests sent by the user
    public static ArrayList<FriendRequest> getSentFriendRequests(int userId) throws SQLException {
        return getRequests(userId, true, false);
    }

    public static List<Integer> getSentFriendRequestsReceiverIds(int userId) throws SQLException {
        String query = "SELECT * FROM FRIEND_REQUESTS WHERE user_one = " + userId + ";";
        ResultSet rs = connection.prepareStatement(query).executeQuery();
        List<Integer> receiverIds = new ArrayList<>();
        while(rs.next()) {
            receiverIds.add(rs.getInt("user_two"));
        }
        return receiverIds;
    }

    //returns unordered friendRequests received by the user
    public static ArrayList<FriendRequest> getReceivedFriendRequests(int userId) throws SQLException {
        return getRequests(userId, false, false);
    }

    public static List<Integer> getReceivedFriendRequestsSenderIds(int userId) throws SQLException {
        String query = "SELECT * FROM FRIEND_REQUESTS WHERE user_two = " + userId + ";";
        ResultSet rs = connection.prepareStatement(query).executeQuery();
        List<Integer> senderIds = new ArrayList<>();
        while(rs.next()) {
            senderIds.add(rs.getInt("user_one"));
        }
        return senderIds;
    }

    //returns latest friendRequests sent by the user
    public static ArrayList<FriendRequest> getLatestSentFriendRequests(int userId) throws SQLException {
        return getRequests(userId, true, true);
    }

    //returns latest friendRequests received by the user
    public static ArrayList<FriendRequest> getLatestReceivedFriendRequests(int userId) throws SQLException {
        return getRequests(userId, false, true);
    }

    //returns list of friendRequests that satisfy given conditions
    private static ArrayList<FriendRequest> getRequests(int userId, boolean sender, boolean latest) throws SQLException {
        String userColumn = "";
        if(sender) userColumn = "user_one";
        else userColumn = "user_two";
        String script = "SELECT * FROM FRIEND_REQUESTS WHERE "+ userColumn + " = " + userId;
        if(latest) script+=" ORDER BY request_send_date DESC";
        ArrayList<FriendRequest> receivedRequests = new ArrayList<>();
        ResultSet resultSet = connection.prepareStatement(script).executeQuery();
        while(resultSet.next()) {
            receivedRequests.add(new FriendRequest(resultSet.getInt("user_one"), resultSet.getInt("user_two"),
                    resultSet.getTimestamp("request_send_date")));
        }
        return receivedRequests;
    }
}
