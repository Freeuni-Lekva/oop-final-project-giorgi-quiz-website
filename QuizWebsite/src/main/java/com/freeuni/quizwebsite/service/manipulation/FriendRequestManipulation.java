package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;
import com.freeuni.quizwebsite.model.db.FriendRequest;
import com.freeuni.quizwebsite.model.db.User;

import java.sql.Connection;
import java.sql.SQLException;

public class FriendRequestManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static void addFriendRequest(FriendRequest fr) throws SQLException {
        String update = String.format("INSERT INTO FRIEND_REQUESTS (user_one, user_two, request_send_date) " +
                                      "VALUES (%s, %s, %s)",
                    fr.getUserOneId(), fr.getUserTwoId(), fr.getFriendshipDate());
        connection.prepareStatement(update).executeUpdate();
    }

    public static void addFriendRequestByIds(int senderId, int receiverId) throws SQLException {
        String update = String.format("INSERT INTO FRIEND_REQUESTS (user_one, user_two) " +
                                      "VALUES (%s, %s)",
                    senderId, receiverId);
        connection.prepareStatement(update).executeUpdate();
    }

    public static void deleteFriendRequest(FriendRequest fr) throws SQLException {
        String update = String.format("DELETE FROM FRIEND_REQUESTS " +
                        "WHERE (user_one = %1$s AND user_two = %2$s) " +
                        "OR (user_one = %2$s AND user_two = %1$s)",
                    fr.getUserOneId(), fr.getUserTwoId());
        connection.prepareStatement(update).executeUpdate();
    }

    public static void deleteFriendRequestByIds(int senderId, int receiverId) throws SQLException {
        String update = String.format("DELETE FROM FRIEND_REQUESTS " +
                        "WHERE (user_one = %1$s AND user_two = %2$s) " +
                        "OR (user_one = %2$s AND user_two = %1$s)",
                    senderId, receiverId);
        connection.prepareStatement(update).executeUpdate();
    }

    public static void deleteAllRequestsById(int userId) throws SQLException {
        String update = "DELETE FROM FRIEND_REQUESTS " +
                        "WHERE user_one = " + userId + " OR " +
                        "user_two = " + userId + ";";
        connection.prepareStatement(update).executeUpdate();
    }

}
