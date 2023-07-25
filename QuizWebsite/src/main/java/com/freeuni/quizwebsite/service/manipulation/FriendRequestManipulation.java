package com.freeuni.quizwebsite.service.manipulation;

import com.freeuni.quizwebsite.db_connection.ConnectToDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FriendRequestManipulation {

    private static final Connection connection = ConnectToDB.getConnection();

    public static void deleteFriendRequest(int senderId, int receiverId) throws SQLException {
        String update = String.format("DELETE FROM FRIEND_REQUESTS " +
                "WHERE (user_one = %s AND user_two = %s)" +
                " OR (user_one = %s AND user_two = %s)", senderId, receiverId, receiverId, senderId);
        connection.prepareStatement(update).executeUpdate();
    }

    public static void addFriendRequest(int senderId, int receiverId) throws SQLException {
        String update = String.format("INSERT INTO FRIEND_REQUESTS (user_one, user_two) VALUES (%s, %s)", senderId, receiverId);
        connection.prepareStatement(update).executeUpdate();
    }
}
